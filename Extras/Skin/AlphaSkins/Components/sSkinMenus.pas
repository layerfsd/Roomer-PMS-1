unit sSkinMenus;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  {$IFDEF DELPHI6UP}  Types,      {$ENDIF}
  {$IFDEF DELPHI_XE2} UITypes,    {$ENDIF}
  {$IFDEF LOGGED}     sDebugMsgs, {$ENDIF}
  {$IFDEF TNTUNICODE} TntMenus,   {$ENDIF}
  sConst;


type
  TsMenuItemType = (smCaption, smDivider, smNormal, smTopLine);
  TsMenuManagerDrawItemEvent = procedure(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState; ItemType: TsMenuItemType) of object;


  TacMenuSupport = class(TPersistent)
  private
    FIcoLineSkin:    TsSkinSection;
    FExtraLineWidth: integer;
    FCustomFont:     boolean;
    FUseExtraLine:   boolean;
    FExtraLineFont:  TFont;
    FAlphaBlend:     byte;
    FFont:           TFont;
    procedure SetExtraLineFont(const Value: TFont);
    procedure SetCustomFont(const Value: boolean);
    procedure SetFont(const Value: TFont);

    function FontStored: boolean;
    function ExtraFontStored: boolean;
    function LineSkinStored: boolean;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property AlphaBlend:     byte          read FAlphaBlend     write FAlphaBlend       default MaxByte;
    property ExtraLineFont:  TFont         read FExtraLineFont  write SetExtraLineFont  stored ExtraFontStored;
    property ExtraLineWidth: integer       read FExtraLineWidth write FExtraLineWidth   default 32;
    property IcoLineSkin:    TsSkinSection read FIcoLineSkin    write FIcoLineSkin      stored LineSkinStored;
    property Font:           TFont         read FFont           write SetFont           stored FontStored;
    property CustomFont:     boolean       read FCustomFont     write SetCustomFont     default False;
    property UseExtraLine:   boolean       read FUseExtraLine   write FUseExtraLine     default False;
  end;


  TMenuItemData = record
    Item: TMenuItem;
    R: TRect;
  end;


  TacMenuInfo = record
    FirstItem:     TMenuItem;
    Bmp:           TBitmap;
    Wnd:           hwnd;
    HaveExtraLine,
    ItemsIterated: boolean;
  end;


{$IFNDEF FPC}
  TsSkinableMenus = class(TPersistent)
  private
    FMargin,
    FSpacing,
    FBevelWidth,
    FBorderWidth,
    FSkinBorderWidth: integer;

    it: TsMenuItemType;
    FCaptionFont: TFont;
    FAlignment: TAlignment;
    procedure SetCaptionFont(const Value: TFont);
    procedure SetAlignment  (const Value: TAlignment);
    procedure SetBevelWidth (const Value: integer);
    procedure SetBorderWidth(const Value: integer);
    function GetSkinBorderWidth: integer;
    function GetCaptionFont: TFont;
  protected
    FOnDrawItem: TsMenuManagerDrawItemEvent;
    function ParentHeight (aCanvas: TCanvas; Item: TMenuItem): integer;
    function GetItemHeight(aCanvas: TCanvas; Item: TMenuItem): integer;
    function ParentWidth  (aCanvas: TCanvas; Item: TMenuItem): integer;
    function GetItemWidth (aCanvas: TCanvas; Item: TMenuItem; const mi: TacMenuInfo): integer;
    procedure PaintDivider(aCanvas: TCanvas; aRect: TRect; Item: TMenuItem; MenuBmp: TBitmap; const mi: TacMenuInfo);
    procedure PaintCaption(aCanvas: TCanvas; aRect: TRect; Item: TMenuItem; BG:      TBitmap; const mi: TacMenuInfo);
    function IsDivText(Item: TMenuItem): boolean;
    function ItemRect (Item: TMenuItem; aRect: TRect): TRect;
    function CursorMarginH: integer;
    function CursorMarginV: integer;
    procedure UpdateFont(aCanvas: TCanvas; aItem: TMenuItem; aBold: boolean; aCaption: boolean = False);
  public
    Pressed,
    FActive,
    BorderDrawing: boolean;

    ArOR: TRects;
    FOwner: TComponent;
    MenuProvider: TObject;
    function IsTopLine(Item: TMenuItem): boolean;
    procedure sMeasureItem     (Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure sAdvancedDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
    procedure DrawWndBorder(Wnd: hWnd; MenuBmp: TBitmap);
    function PrepareMenuBG(Item: TMenuItem; Width, Height: integer; Wnd: hwnd = 0): TBitmap;

    procedure sMeasureLineItem     (Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure sAdvancedDrawLineItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);

    procedure SetActive(const Value: boolean);
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure InitItem(Item: TMenuItem; A: boolean);
    procedure InitItems(A: boolean);
    procedure InitMenuLine(Menu: TMainMenu; A: boolean);
    procedure HookItem(MenuItem: TMenuItem; AActive: boolean);
    procedure HookPopupMenu(Menu: TPopupMenu; Active: boolean);
    procedure UpdateMenus;
    function LastItem(Item: TMenuItem): boolean;
    function IsPopupItem(Item: TMenuItem): boolean;
    function GetMenuInfo(Item: TMenuItem; const aWidth, aHeight: integer; aCanvas: TCanvas; aWnd: hwnd = 0): TacMenuInfo;

    function ExtraWidth(const mi: TacMenuInfo): integer;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property BevelWidth: integer read FBevelWidth write SetBevelWidth default 0;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 3;
    property CaptionFont: TFont read GetCaptionFont write SetCaptionFont;
    property SkinBorderWidth: integer read GetSkinBorderWidth write FSkinBorderWidth;
    property Margin: integer read FMargin write FMargin default 2;
    property Spacing: integer read FSpacing write FSpacing default 8;
    property OnDrawItem: TsMenuManagerDrawItemEvent read FOnDrawItem write FOnDrawItem;
  end;
{$ENDIF}


function GetFirstItem(Item: TMenuItem): TMenuItem;
procedure DeleteUnusedBmps(DeleteAll: boolean);
function ChildIconPresent: boolean;
{$IFNDEF FPC}
procedure ClearCache;
{$ENDIF}


var
  MDISkinProvider: TObject;
  acCanHookMenu: boolean = False;
  CustomMenuFont: TFont = nil;


const
  s_SysMenu = 'acSysMenu';


implementation

uses
  math, StdCtrls, ImgList,
  {$IFDEF TNTUNICODE} TntWindows, {$ENDIF}
  sDefaults, sStyleSimply, sSkinProvider, sMaskData, sSkinProps, sThirdParty,
  sGraphUtils, acntUtils, sAlphaGraph, sSkinManager, sVclUtils, sMessages;


const
  DontForget = 'Use OnGetExtraLineData event';


var
  Measuring: boolean = False;
  MenuInfoArray: array of TacMenuInfo;
  AlignToInt: array [TAlignment] of Cardinal = (DT_LEFT, DT_RIGHT, DT_CENTER);

  // Temp data
  IcoLineWidth: integer = 0;
  GlyphSizeCX:  integer = 0;

  ExtraCaption, ExtraSection: string;
  ExtraGlyph: TBitmap;

  
function ChildIconPresent: boolean;
begin
  if MDISkinProvider <> nil then
    with TsSkinProvider(MDISkinProvider), Form do
      Result := (Form <> nil) and (FormStyle = fsMDIForm) and (ActiveMDIChild <> nil) and
                (ActiveMDIChild.WindowState = wsMaximized) and (biSystemMenu in ActiveMDIChild.BorderIcons) and
                Assigned(ActiveMDIChild.Icon)
  else
    Result := False;
end;


function GetFirstItem(Item: TMenuItem): TMenuItem;
begin
  Result := Item.Parent.Items[0];
end;


procedure DeleteUnusedBmps(DeleteAll: boolean);
var
  i, l: integer;
begin
  l := Length(MenuInfoArray);
  for i := 0 to l - 1 do
    MenuInfoArray[i].Bmp.Free;

  SetLength(MenuInfoArray, 0);
end;


function Breaked(MenuItem: TMenuItem): boolean;
var
  i: integer;
begin
  Result := False;
{$IFNDEF FPC}
  for i := 1 to MenuItem.MenuIndex do
    if MenuItem.Parent.Items[i].Break <> mbNone then begin
      Result := True;
      Exit;
    end;
{$ENDIF}
end;


function GlyphSize(Item: TMenuItem; Top: boolean): TSize;
var
  mi: TMenu;
begin
  Result := MkSize;
  if Top then begin
    if not Item.Bitmap.Empty then
      Result := MkSize(Item.Bitmap)
  end
  else
    if not Item.Bitmap.Empty then
      Result := MkSize(Item.Bitmap)
    else
      if Assigned(Item.Parent) and (Item.Parent.SubMenuImages <> nil) then
        Result := MkSize(Item.Parent.SubMenuImages.Width)
      else begin
        mi := Item.GetParentMenu;
        if Assigned(mi) and Assigned(mi.Images) then
          Result := MkSize(Item.GetParentMenu.Images.Width, Item.GetParentMenu.Images.Height)
        else
          Result := MkSize(16, 16)
      end;
end;


{$IFNDEF FPC}
constructor TsSkinableMenus.Create(AOwner: TComponent);
begin
  FOwner := AOwner;
  FActive := False;
  FCaptionFont := TFont.Create;
  BorderDrawing := False;
  FBorderWidth := 3;
  FBevelWidth := 0;
  FSpacing := 8;
  FMargin := 2;
end;


procedure TsSkinableMenus.sAdvancedDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
const
  s_Webdings = 'Webdings';
var
  Wnd: hwnd;
  NewDC: hdc;
  aMsg: TMSG;
  RTL: boolean;
  gChar: string;
  Item: TMenuItem;
  mi: TacMenuInfo;
  sm: TsSkinManager;
  DrawStyle: Cardinal;
  R, gRect, cRect: TRect;
  Text, TabText: acString;
  ItemBmp, BGImage: TBitmap;
  ItemData: TacMenuItemData;
  DrawData: TacDrawGlyphData;
  i, j, c, l, Br, w, h: integer;

  function TextRect: TRect;
  begin
    Result := aRect;
    OffsetRect(Result, - aRect.Left, - aRect.Top);
    if RTL then
      dec(Result.Right, Margin * 2 + GlyphSize(Item, False).cx + Spacing)
    else
      inc(Result.Left, Margin * 2 + GlyphSize(Item, False).cx + Spacing);
  end;

  function ShortCutRect(const s: acString): TRect;
  var
    tr: TRect;
  begin
    Result := aRect;
    tR := MkRect(1, 0);
    acDrawText(ItemBmp.Canvas.Handle, PacChar(Text), tR, DT_EXPANDTABS or DT_SINGLELINE or DT_CALCRECT);
    OffsetRect(Result, - aRect.Left, - aRect.Top);
    if RTL then
      Result.Left := 6
    else
      Result.Left := aRect.Right - WidthOf(tr) - 8;
  end;

  function IsTopVisible(Item: TMenuItem): boolean;
  var
    i: integer;
  begin
    Result := False;
    for i := 0 to Item.Parent.Count - 1 do
      if Item.Parent.Items[i].Visible then begin
        if Item.Parent.Items[i] = Item then
          Result := True;

        Break
      end;
  end;

  function IsBtmVisible(Item: TMenuItem): boolean;
  var
    i: integer;
  begin
    Result := False;
    for i := 0 to Item.Parent.Count - 1 do
      if Item.Parent.Items[Item.Parent.Count - 1 - i].Visible then begin
        if Item.Parent.Items[Item.Parent.Count - 1 - i] = Item then
          Result := True;
          
        Break
      end;
  end;

begin
  if (FOwner <> nil) and TsSkinManager(FOwner).Active then begin
    sm := TsSkinManager(FOwner);
    Item := TMenuItem(Sender);
    // Get RTL value from parent menu
    RTL := SysLocale.MiddleEast and (Item.GetParentMenu.BiDiMode <> bdLeftToRight);
    Br := integer(not Breaked(Item) or (Item.Parent.Items[0] = Item));
    if TempControl <> nil then begin
      if ShowHintStored then
        Application.ShowHint := AppShowHint;
      
      SendAMessage(TControl(TempControl), WM_MOUSELEAVE);
      TempControl := nil;
    end;
    ACanvas.Lock;
    try
      if IsNT then
        Wnd := WindowFromDC(ACanvas.Handle)
      else
        Wnd := 0;

      mi := GetMenuInfo(Item, 0, 0, ACanvas, Wnd);
      R := MkRect(mi.Bmp);
      BGImage := mi.Bmp; // !
      if IsNT and (Wnd <> 0) then begin // Drawing is needed for cases when WM_NCPAINT is not received
        NewDC := GetWindowDC(Wnd);
        if (BGImage <> nil) and (BGImage.Canvas.Handle <> 0) then
          try
            if IsTopVisible(Item) then begin // First item
              BitBlt(NewDC, 0, 0, BGImage.Width, BorderWidth, BGImage.Canvas.Handle, 0, 0, SRCCOPY);
              // Left border
              BitBlt(NewDC, 0, 0, ExtraWidth(mi) * Br + max(SkinBorderWidth, BorderWidth), mi.Bmp.Height, BGImage.Canvas.Handle, 0, 0, SRCCOPY);
            end;
            if IsBtmVisible(Item) then // Last item
              BitBlt(NewDC, 0, BGImage.Height - BorderWidth, BGImage.Width, BorderWidth, BGImage.Canvas.Handle, 0, BGImage.Height - BorderWidth, SRCCOPY);
            // Right border
            BitBlt(NewDC, BGImage.Width - BorderWidth, aRect.Top + BorderWidth, BorderWidth, HeightOf(aRect),
                   BGImage.Canvas.Handle, BGImage.Width - BorderWidth, aRect.Top + BorderWidth, SRCCOPY);
          finally
            ReleaseDC(Wnd, NewDC);
          end;
      end;
      if (Wnd = 0) and (Application.{$IFDEF FPC}MainFormHandle{$ELSE}Handle{$ENDIF} <> 0) then
        if not PeekMessage(aMsg, Application.{$IFDEF FPC}MainFormHandle{$ELSE}Handle{$ENDIF}, WM_DRAWMENUBORDER, WM_DRAWMENUBORDER2, PM_NOREMOVE) then
          PostMessage(Application.{$IFDEF FPC}MainFormHandle{$ELSE}Handle{$ENDIF}, WM_DRAWMENUBORDER, 0, Integer(Item));

      if Item.IsLine then begin
        PaintDivider(aCanvas, aRect, Item, BGImage, mi);
        ACanvas.UnLock;
        Exit;
      end
      else
        if IsDivText(Item) then begin
          mi := GetMenuInfo(Item, WidthOf(R), HeightOf(R), ACanvas, Wnd);
          PaintCaption(aCanvas, aRect, Item, BGImage, mi);
          ACanvas.UnLock;
          Exit;
        end;

      it := smNormal;
      if BGImage = nil then begin
        ACanvas.UnLock;
        Exit;
      end;

      i := sm.ConstData.MenuItem.SkinIndex;
      // Check for multi-columned menus...
      if Item.MenuIndex < Item.Parent.Count - 1 then begin
{$IFNDEF FPC}
        if not mi.ItemsIterated and (Item.Break = mbBarBreak{mbNone}) then begin
          if i >= 0 then
            C := sm.gd[i].Props[0].FontColor.Color
          else
            C := clGray;

          FillDC(BGImage.Canvas.Handle, Rect(aRect.Left, 0, aRect.Left + 1, BGImage.Height), C);
        end;
        if Item.Parent.Items[Item.MenuIndex + 1].Break <> mbNone then
          BitBlt(ACanvas.Handle, aRect.Left, aRect.Bottom, WidthOf(aRect), BGImage.Height - 6 - aRect.Bottom, BGImage.Canvas.Handle, aRect.Left + 3, aRect.Bottom + 3, SrcCopy);
{$ENDIF}
      end
      else begin
        if aRect.Bottom < BGImage.Height - 6 then
          BitBlt(ACanvas.Handle, aRect.Left, aRect.Bottom, WidthOf(aRect), BGImage.Height - 6 - aRect.Bottom, BGImage.Canvas.Handle, aRect.Left + 3, aRect.Bottom + 3, SrcCopy);

        mi.ItemsIterated := True;
      end;
{$IFNDEF FPC}
      if Item.Break <> mbNone then
        BitBlt(ACanvas.Handle, aRect.Left - 4, aRect.Top, 4, BGImage.Height - 6, BGImage.Canvas.Handle, aRect.Left - 1, aRect.Top + 3, SrcCopy);
{$ENDIF}
      ItemBmp := CreateBmp32(max(WidthOf(aRect, True) - ExtraWidth(mi) * Br, 0), HeightOf(aRect, True));
      // Draw MenuItem
      if TsSkinManager(FOwner).IsValidSkinIndex(i) then
        PaintItem(i, MakeCacheInfo(BGImage, 3, 3), True, integer(Item.Enabled and (odSelected in State)), MkRect(ItemBmp.Width, HeightOf(aRect)),
                  Point(aRect.Left + ExtraWidth(mi) * Br, aRect.Top), ItemBmp.Canvas.Handle, FOwner);

      if odChecked in State then
        if Item.Bitmap.Empty and ((Item.GetImageList = nil) or (Item.ImageIndex < 0)) then begin
          if Item.RadioItem then
            j := sm.ConstData.RadioButton[True]
          else
            j := sm.GetMaskIndex(sm.ConstData.IndexGLobalInfo, s_CheckGlyph);

          if j < 0 then
            j := sm.ConstData.CheckBox[cbChecked];

          if j >= 0 then begin
            cRect.Top := (HeightOf(aRect) - sm.ma[j].Height) div 2;
            l := sm.ma[j].Width;
            if RTL then
              cRect.Left := min(ItemBmp.Width - l, ItemBmp.Width - (GlyphSizeCX - l) div 2 - l - Margin)
            else
              cRect.Left := max(0, (GlyphSizeCX - l) div 2 + Margin);

            cRect.Right := cRect.Left + l;
            cRect.Bottom := cRect.Top + sm.ma[j].Height;
            DrawSkinGlyph(ItemBmp, cRect.TopLeft, integer(Item.Enabled and (odSelected in State)), 1, sm.ma[j], MakeCacheInfo(ItemBmp))
          end
        end;

      if not Item.Bitmap.Empty or (Item.GetImageList <> nil) and (Item.ImageIndex >= 0) and (Item.ImageIndex < Item.GetImageList.Count) then begin
        if not Item.Bitmap.Empty then begin
          w := Item.Bitmap.Width;
          h := Item.Bitmap.Height;
          DrawData.Images := nil;
          DrawData.Glyph := Item.Bitmap;
        end
        else begin
          w := Item.GetImageList.Width;
          h := Item.GetImageList.Height;
          DrawData.ImageIndex := Item.ImageIndex;
          DrawData.Images := Item.GetImageList;
          DrawData.Glyph := nil;
        end;
        gRect.Top := (ItemBmp.Height - h) div 2;
        if RTL then
          gRect.Left := ARect.Right - gRect.Top - w - ExtraWidth(mi)
        else
          gRect.Left := min(3, gRect.Top);

        gRect.Bottom := gRect.Top + h;
        gRect.Right := gRect.Left + w;
        DrawData.ImgRect := gRect;
        DrawData.SkinManager := TsSkinManager(FOwner);
        DrawData.DisabledGlyphKind := [];//DefDisabledGlyphKind;
        DrawData.Enabled := Item.Enabled;
        DrawData.CurrentState := integer(Item.Enabled and (odSelected in State));
        DrawData.Blend := 0;

        if odChecked in State then begin
          j := TsSkinManager(FOwner).ConstData.Sections[ssSpeedButton_Small];
          if j >= 0 then begin
            InflateRect(gRect, 1, 1);
            PaintItem(j, MakeCacheInfo(ItemBmp), True, 2, gRect, MkPoint, ItemBmp, TsSkinManager(FOwner));
            InflateRect(gRect, -1, -1);
          end;
        end;
        DrawData.Grayed := (dgGrayed in DefDisabledGlyphKind) and not Item.Enabled or DrawData.SkinManager.Effects.DiscoloredGlyphs and not (odSelected in State);
        DrawData.DstBmp := ItemBmp;
        DrawData.Canvas := ItemBmp.Canvas;
        DrawData.BGColor := DrawData.SkinManager.gd[i].Props[DrawData.CurrentState].Color;
        DrawData.NumGlyphs := 1;
        acDrawGlyphEx(DrawData);
      end
      else
        if (Item.GetParentMenu <> nil) and (pos(s_SysMenu, Item.GetParentMenu.Name) = 1) then begin
          gChar := #0;
          ItemBmp.Canvas.Font.Name := s_Webdings;
          ItemBmp.Canvas.Font.Style := [];
          ItemBmp.Canvas.Font.Size := 10;
          if TsSkinManager(FOwner) <> nil then
            ItemBmp.Canvas.Font.Size := TsSkinManager(FOwner).ScaleInt(ItemBmp.Canvas.Font.Size, TsSkinManager(FOwner).SysFontScale);

          case Item.Tag of
            SC_MINIMIZE: gChar := ZeroChar;
            SC_MAXIMIZE: gChar := CharOne;
            SC_RESTORE:  gChar := '2';
            SC_CLOSE:    gChar := 'r'
          end;
          if gChar <> #0 then begin
            j := ItemBmp.Canvas.TextHeight(gChar);
            gRect.Top := (ItemBmp.Height - j) div 2;
            gRect.Bottom := gRect.Top + j;
            j := ItemBmp.Canvas.TextWidth(gChar);
            if RTL then begin
              gRect.Right := aRect.Right - (IcoLineWidth - j) div 2 + 1;
              gRect.Left := gRect.Right - j;
              DrawStyle := DT_RIGHT;
            end
            else begin
              gRect.Left := (IcoLineWidth - j) div 2 - 1;
              gRect.Right := gRect.Left + j;
              DrawStyle := 0;
            end;
            sGraphUtils.acWriteTextEx(ItemBmp.Canvas, PacChar(gChar), True, gRect, DrawStyle, i, (Item.Enabled and ((odSelected in State) or (odHotLight in State))), FOwner);
          end;
        end;

      UpdateFont(ItemBmp.Canvas, Item, odDefault in State);
      // Text writing
      ItemData.Font := ItemBmp.Canvas.Font;
      if Assigned(TsSkinManager(FOwner).OnGetPopupItemData) then begin
        c := ItemBmp.Canvas.Font.Color;
        TsSkinManager(FOwner).OnGetPopupItemData(Item, State, ItemData);
        SelectObject(ItemBmp.Canvas.Handle, ItemBmp.Canvas.Font.Handle);
        if ItemBmp.Canvas.Font.Color <> c then
          i := -1;
      end;
      R := TextRect;
      inc(R.Top);

{$IFDEF TNTUNICODE}
      if Sender is TTntMenuItem then
        Text := TTntMenuItem(Sender).Caption
      else
{$ENDIF}
        Text := Item.Caption;

      c := pos(#9, Text);
      DrawStyle := 0;
      if c <> 0 then begin
        l := Length(Text) - c;
        TabText := copy(Text, c + 1, l);
        delete(Text, c, l + 1);
      end
      else
        if (Text <> '') and (Text[1] = #8) then begin
          Delete(Text, 1, 1);
          Text := Text + '      ';
          DrawStyle := AlignToInt[taRightJustify];
        end
        else
          DrawStyle := AlignToInt[Alignment];

      DrawStyle := DrawStyle or DT_EXPANDTABS or DT_VCENTER or DT_NOCLIP or Cardinal(iff(pos(#13, Text) > 0, DT_WORDBREAK, DT_SINGLELINE));
      if RTL then begin
        DrawStyle := DrawStyle or DT_RIGHT;
        dec(R.Right, ExtraWidth(mi));
      end;
      if odNoAccel in State then
        DrawStyle := DrawStyle or DT_HIDEPREFIX;

      if RTL then
        DrawStyle := DrawStyle or DT_RTLREADING;

      InflateRect(R, 0, -Margin);
      sGraphUtils.acWriteTextEx(ItemBmp.Canvas, PacChar(Text), True, R, DrawStyle, i, Item.Enabled and ((odSelected in State) or (odHotLight in State)), FOwner);
      Text := ShortCutToText(TMenuItem(Sender).ShortCut);
      if Text <> '' then begin
        DrawStyle := DT_SINGLELINE or DT_VCENTER or DT_LEFT;
        r := ShortCutRect(Text);
        dec(r.Right, 8);
        OffsetRect(R, -ExtraWidth(mi), 0);
        sGraphUtils.acWriteTextEx(ItemBmp.Canvas, PacChar(Text), True, R, DrawStyle, i, Item.Enabled and ((odSelected in State) or (odHotLight in State)), FOwner);
      end;
      if TabText <> '' then begin
        DrawStyle := DT_SINGLELINE or DT_VCENTER or DT_RIGHT;
        dec(r.Right, 8);
        OffsetRect(R, -ExtraWidth(mi), 0);
        sGraphUtils.acWriteTextEx(ItemBmp.Canvas, PacChar(TabText), True, R, DrawStyle, i, Item.Enabled and ((odSelected in State) or (odHotLight in State)), FOwner);
      end;
      if Assigned(FOnDrawItem) then
        FOnDrawItem(Item, ItemBmp.Canvas, MkRect(ItemBmp), State, it);

      if not Item.Enabled then begin
        R := aRect;
        OffsetRect(R, BorderWidth + ExtraWidth(mi) * Br, BorderWidth);
        BlendTransRectangle(ItemBmp, 0, 0, BGImage, R, DefBlendDisabled);
      end;
      BitBlt(ACanvas.Handle, aRect.Left + ExtraWidth(mi) * Br, aRect.Top, ItemBmp.Width, ItemBmp.Height, ItemBmp.Canvas.Handle, 0, 0, SrcCopy);
      if (Item = Item.Parent.Items[0]) and (ExtraWidth(mi) > 0) and (not IsNT or (Win32MajorVersion >= 6)) then
        BitBlt(ACanvas.Handle, 0, 0, ExtraWidth(mi) * Br, BGImage.Height, BGImage.Canvas.Handle, 3, 3, SRCCOPY);

      FreeAndNil(ItemBmp);
    finally
      if Assigned(Item.OnDrawItem) then
        Item.OnDrawItem(Item, ACanvas, ARect, odSelected in State);

      ACanvas.UnLock;
    end;
  end;
end;


procedure TsSkinableMenus.InitItems(A: boolean);
var
  i: integer;

  procedure ProcessComponent(c: TComponent);
  var
    i: integer;
  begin
    if c <> nil then begin
      if c is TMainMenu then begin
        InitMenuLine(TMainMenu(c), A);
        for i := 0 to TMainMenu(c).Items.Count - 1 do
          HookItem(TMainMenu(c).Items[i], A and TsSkinManager(FOwner).SkinnedPopups);
      end
      else
        if c is TPopupMenu then
          HookPopupMenu(TPopupMenu(c), A and TsSkinManager(FOwner).SkinnedPopups)
        else
          if (c is TMenuItem) and not (TMenuItem(c).GetParentMenu is TMainMenu) then
            HookItem(TMenuItem(c), A and TsSkinManager(FOwner).SkinnedPopups);

      for i := 0 to c.ComponentCount - 1 do
        ProcessComponent(c.Components[i]);
    end;
  end;

begin
  FActive := A;
  if not (csDesigning in Fowner.ComponentState) then
    for i := 0 to Application.ComponentCount - 1 do
      ProcessComponent(Application.Components[i]);
end;


procedure TsSkinableMenus.HookItem(MenuItem: TMenuItem; AActive: boolean);
var
  i: integer;

  procedure HookSubItems(Item: TMenuItem);
  var
    i: integer;
  begin
    for i := 0 to Item.Count - 1 do begin
      if AActive then begin
        if not IsTopLine(Item.Items[i]) then begin
          if not Assigned(Item.Items[i].OnAdvancedDrawItem) then
            Item.Items[i].OnAdvancedDrawItem := sAdvancedDrawItem;

          if not Assigned(Item.Items[i].OnMeasureItem) then
            Item.Items[i].OnMeasureItem := sMeasureItem;
        end;
      end
      else begin
        if addr(Item.Items[i].OnAdvancedDrawItem) = addr(TsSkinableMenus.sAdvancedDrawItem) then
          Item.Items[i].OnAdvancedDrawItem := nil;

        if addr(Item.Items[i].OnMeasureItem) = addr(TsSkinableMenus.sMeasureItem) then
          Item.Items[i].OnMeasureItem := nil;
      end;
      HookSubItems(Item.Items[i]);
    end;
  end;

begin
  for i := 0 to MenuItem.Count - 1 do begin
    if AActive then begin
      if not IsTopLine(MenuItem.Items[i]) then begin
        if not Assigned(MenuItem.Items[i].OnAdvancedDrawItem) then
          MenuItem.Items[i].OnAdvancedDrawItem := sAdvancedDrawItem;

        if not Assigned(MenuItem.Items[i].OnMeasureItem) then
          MenuItem.Items[i].OnMeasureItem := sMeasureItem;
      end;
    end
    else begin
      if addr(MenuItem.Items[i].OnAdvancedDrawItem) = addr(TsSkinableMenus.sAdvancedDrawItem) then
        MenuItem.Items[i].OnAdvancedDrawItem := nil;

      if addr(MenuItem.Items[i].OnMeasureItem) = addr(TsSkinableMenus.sMeasureItem) then
        MenuItem.Items[i].OnMeasureItem := nil;
    end;
    HookSubItems(MenuItem.Items[i]);
  end;
end;


procedure TsSkinableMenus.SetActive(const Value: boolean);
begin
  if FActive <> Value then begin
    FActive := Value;
    InitItems(Value);
  end
end;


procedure TsSkinableMenus.sMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
var
  R: TRect;
  Text: acString;
  Item: TMenuItem;
  mi: TacMenuInfo;
  ItemData: TacMenuItemData;
begin
  if not (csDestroying in TComponent(Sender).ComponentState) then begin
    acCanHookMenu := True;
    Item := TMenuItem(Sender);
    mi := GetMenuInfo(Item, 0, 0, nil);
    if Item.Caption = cLineCaption then
      it := smDivider
    else
      if IsdivText(Item) then
        it := smCaption
      else
        it := smNormal;

    if mi.FirstItem = nil then begin // if not defined still
      mi.FirstItem := Item.Parent.Items[0];
      if not Measuring and not (csDesigning in TsSkinManager(FOwner).ComponentState) then
        if mi.FirstItem.Name <> s_SkinSelectItemName then begin
          Measuring := True;
          ExtraSection := s_MenuExtraLine;
          if ExtraGlyph <> nil then
            FreeAndNil(ExtraGlyph);

          ExtraCaption := DontForget;
          mi.HaveExtraLine := True;
          if Assigned(TsSkinManager(FOwner).OnGetMenuExtraLineData) then
            TsSkinManager(FOwner).OnGetMenuExtraLineData(mi.FirstItem, ExtraSection, ExtraCaption, ExtraGlyph, mi.HaveExtraLine);

          ExtraCaption := DelChars(ExtraCaption, '&');
          if not mi.HaveExtraLine and Assigned(ExtraGlyph) then
            FreeAndNil(ExtraGlyph);

          Measuring := False;
        end
        else
          mi.HaveExtraLine := False;
    end;

    UpdateFont(ACanvas, Item, Item.Default);
{    if Assigned(CustomMenuFont) then
      ACanvas.Font.Assign(CustomMenuFont)
    else
      if Assigned(Screen.MenuFont) then
        ACanvas.Font.Assign(Screen.MenuFont);

    f := GetOwnerForm(Item.GetParentMenu);
    if f <> nil then
      ACanvas.Font.Charset := f.Font.Charset;

    if Item.Default then
      ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];

    ACanvas.Font.Height := TsSkinManager(FOwner).ScaleInt(ACanvas.Font.Height);
}
    case it of
      smDivider:
        R := MkRect(1, 0);

      smCaption: begin
        Text := Item.Caption;
        R := MkRect(acTextWidth(ACanvas, Text), 0);
      end

      else begin
        Text := Item.Caption + iff(ShortCutToText(Item.ShortCut) = '', '', ShortCutToText(Item.ShortCut));
        R := MkRect(800, 0);
      end;
    end;

    ItemData.Font := ACanvas.Font;
    if Assigned(TsSkinManager(FOwner).OnGetPopupItemData) then begin
      TsSkinManager(FOwner).OnGetPopupItemData(Item, [], ItemData);
      SelectObject(ACanvas.Handle, ACanvas.Font.Handle);
    end;

    if Text = '' then
      Width := Margin * 3 + GlyphSize(Item, False).cx * 2 + Spacing
    else begin
  {$IFDEF TNTUNICODE}
      if Sender is TTntMenuItem then
        Tnt_DrawTextW(ACanvas.Handle, PacChar(Text), Length(Text), R, DT_EXPANDTABS or DT_NOCLIP or DT_CALCRECT or DT_WORDBREAK)
      else
  {$ENDIF}
        acDrawText(ACanvas.Handle, PacChar(Text), R, DT_EXPANDTABS or DT_NOCLIP or DT_CALCRECT or DT_WORDBREAK);

      Width := Margin * 3 + WidthOf(R) + GlyphSize(Item, False).cx * 2 + Spacing;
    end;
    if mi.HaveExtraLine and (not Breaked(Item) or (Item.Parent.Items[0] = Item)) then
      inc(Width, ExtraWidth(mi));

    Height := GetItemHeight(aCanvas, Item);
  end;
end;


destructor TsSkinableMenus.Destroy;
begin
  FOwner := nil;
  FreeAndNil(FCaptionFont);
  inherited Destroy;
end;


// Refresh list of all MenuItems on project
procedure TsSkinableMenus.UpdateFont(aCanvas: TCanvas; aItem: TMenuItem; aBold: boolean; aCaption: boolean = False);
var
  f: TCustomForm;
begin
  if Assigned(CustomMenuFont) then
    aCanvas.Font.Assign(CustomMenuFont)
  else
    if aCaption {and Assigned(FCaptionFont)} then
      aCanvas.Font.Assign(CaptionFont)
    else
      if Assigned(Screen.MenuFont) then
        aCanvas.Font.Assign(Screen.MenuFont);

  f := GetOwnerForm(aItem.GetParentMenu);
  if f <> nil then
    aCanvas.Font.Charset := f.Font.Charset;

  if aBold then
    aCanvas.Font.Style := [fsBold];

  aCanvas.Font.Height := TsSkinManager(FOwner).ScaleInt(aCanvas.Font.Height, TsSkinManager(FOwner).SysFontScale);
end;


procedure TsSkinableMenus.UpdateMenus;
begin
  SetActive(TsSkinManager(FOwner).CommonSkinData.Active);
end;


// Return height of the menu panel
function TsSkinableMenus.ParentHeight(aCanvas: TCanvas; Item: TMenuItem): integer;
var
  i, ret: integer;
begin
  ret := 0;
  Result := 0;
  for i := 0 to Item.Parent.Count - 1 do
    if Item.Parent.Items[i].Visible then
      if Item.Parent.Items[i].Break <> mbNone then begin
        Result := max(Result, ret);
        ret := GetItemHeight(aCanvas, Item.Parent.Items[i]);
      end
      else
        inc(ret, GetItemHeight(aCanvas, Item.Parent.Items[i]));

  Result := max(Result, ret);
end;


// Return height of the current MenuItem
function TsSkinableMenus.GetCaptionFont: TFont;
begin
  if Assigned(CustomMenuFont) then
    Result := CustomMenuFont
  else
{    if aCaption and Assigned(FCaptionFont) then
      aCanvas.Font.Assign(FCaptionFont)
    else}
      if Assigned(Screen.MenuFont) then
        Result := Screen.MenuFont
      else
        Result := nil;
end;


function TsSkinableMenus.GetItemHeight(aCanvas: TCanvas; Item: TMenuItem): integer;
var
  R: TRect;
  Text: acString;
  IsDivider: boolean;
begin
  IsDivider  := Item.Caption = cLineCaption;
  if not IsDivider then begin
{$IFDEF TNTUNICODE}
    if Item is TTntMenuItem then
      Text := TTntMenuItem(Item).Caption
    else
{$ENDIF}
      Text := Item.Caption;

    if not IsDivText(Item) then
      Text := Text + iff(ShortCutToText(Item.ShortCut) = '', '', ShortCutToText(Item.ShortCut));
  end;
  if IsDivider then
    Result := 2
  else begin
    R := MkRect(800, 0);
    UpdateFont(ACanvas, Item, Item.Default);
    acDrawText(ACanvas.Handle, PacChar(Text), R, DT_EXPANDTABS or DT_NOCLIP or DT_CALCRECT or DT_WORDBREAK);
    if IsDivText(Item) then
      Result := HeightOf(R) + 2 * (Margin + 1) + 1
    else
      Result := Maxi(HeightOf(R), GlyphSize(Item, False).cy) + 2 * (Margin + 1);
  end;
end;


function TsSkinableMenus.IsDivText(Item: TMenuItem): boolean;
begin
  Result := (copy(Item.Caption, 1, 1) = cMenuCaption) and (copy(Item.Caption, length(Item.Caption), 1) = cMenuCaption);
end;


procedure TsSkinableMenus.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then
    FAlignment := Value;
end;


function TsSkinableMenus.IsTopLine(Item: TMenuItem): boolean;
var
  i: integer;
  m: TMenu;
begin
  Result := False;
  m := Item.GetParentMenu;
  if m is TMainMenu then
    for i := 0 to m.Items.Count - 1 do
      if m.Items[i] = Item then begin
        Result := True;
        Exit;
      end;
end;


procedure TsSkinableMenus.SetBevelWidth(const Value: integer);
begin
  FBevelWidth := Value;
end;


procedure TsSkinableMenus.SetBorderWidth(const Value: integer);
begin
  FBorderWidth := Value;
end;


function TsSkinableMenus.CursorMarginH: integer;
begin
  Result := BorderWidth;
end;


function TsSkinableMenus.CursorMarginV: integer;
begin
  Result := 0;
end;


function TsSkinableMenus.ItemRect(Item: TMenuItem; aRect: TRect): TRect;
begin
  Result := aRect;
  if Item.Parent.Items[0] = Item then
    Result.Top := Result.Top + CursorMarginV;

  if Item.Parent.Items[Item.Parent.Count - 1] = Item then
    Result.Bottom := Result.Bottom - CursorMarginV;

  Result.Left := Result.Left + CursorMarginH;
  Result.Right := Result.Right - CursorMarginH;
end;


procedure TsSkinableMenus.PaintDivider(aCanvas: TCanvas; aRect: TRect; Item: TMenuItem; MenuBmp: TBitmap; const mi: TacMenuInfo);
var
  s: string;
  nRect: TRect;
  CI: TCacheInfo;
  TempBmp: TBitmap;
  SkinIndex, BorderIndex, IcoLineNdx: integer;
begin
  s := s_DividerV;
  with TsSkinManager(FOwner) do begin
    SkinIndex := ConstData.Sections[ssDividerV];
    if SkinIndex >= 0 then
      BorderIndex := gd[SkinIndex].BorderIndex
    else
      BorderIndex := -1;
      
    nRect := aRect;
    IcoLineNdx := GetSkinIndex(MenuSupport.IcoLineSkin);
    if (IcoLineNdx >= 0) and ((gd[IcoLineNdx].Props[0].Transparency < 100) or (gd[IcoLineNdx].BorderIndex >= 0)) then begin
      OffsetRect(nRect, -nRect.Left + Margin + ExtraWidth(mi) + Spacing, -nRect.Top);
      dec(nRect.Right, Margin + Margin + ExtraWidth(mi) + Spacing);
      if nRect.Left < IcoLineWidth + ExtraWidth(mi) then
        nRect.Left := IcoLineWidth + ExtraWidth(mi) + 2;
    end
    else begin
      OffsetRect(nRect, -nRect.Left + Margin + ExtraWidth(mi), -nRect.Top);
      dec(nRect.Right, Margin + Margin + ExtraWidth(mi));
      if nRect.Left < ExtraWidth(mi) then
        nRect.Left := ExtraWidth(mi) + 2;
    end;
    if BorderIndex >= 0 then begin
      TempBmp := CreateBmp32(aRect);
      if MenuBmp <> nil then
        BitBlt(TempBmp.Canvas.Handle, 0, 0, WidthOf(aRect), HeightOf(aRect), MenuBmp.Canvas.Handle, aRect.Left + 3, aRect.Top + 3, SRCCOPY);

      CI := MakeCacheInfo(TempBmp);
      DrawSkinRect(TempBmp, nRect, CI, ma[BorderIndex], 0, True);
      BitBlt(aCanvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
      FreeAndnil(TempBmp);
    end
    else begin
      BitBlt(aCanvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), MenuBmp.Canvas.Handle, aRect.Left + 3, aRect.Top + 3, SRCCOPY);
      if Palette[pcBorder] <> clFuchsia then
        aCanvas.Pen.Color := Palette[pcBorder]
      else
        aCanvas.Pen.Color := clBtnShadow;

      aCanvas.Pen.Style := psSolid;
      aCanvas.MoveTo(nRect.Left, aRect.Top);
      aCanvas.LineTo(nRect.Right, aRect.Top);
    end;
  end;
end;


procedure TsSkinableMenus.PaintCaption(aCanvas: TCanvas; aRect: TRect; Item: TMenuItem; BG: TBitmap; const mi: TacMenuInfo);
var
  R: TRect;
  s: acString;
  ItemBmp: TBitmap;
  i, Flags, Offset: integer;
begin
  ItemBmp := CreateBmp32(aRect);
  R := Rect(ExtraWidth(mi) + 1, 1, ItemBmp.Width - 1, ItemBmp.Height - 1);
  if (TsSkinManager(FOwner).ConstData.Sections[ssMainMenu] < 0) or (TsSkinManager(FOwner).gd[TsSkinManager(FOwner).ConstData.Sections[ssMainMenu]].BorderIndex < 0) then
    Offset := 1
  else
    Offset := 3;

  if ExtraWidth(mi) > 0 then begin
    i := integer(not Breaked(Item) or (Item.Parent.Items[0] = Item));
    BitBlt(ItemBmp.Canvas.Handle, 0, 0, ExtraWidth(mi) * i + max(SkinBorderWidth, BorderWidth), ItemBmp.Height, BG.Canvas.Handle, aRect.Left + Offset, aRect.Top + Offset, SRCCOPY);
  end;

  if TsSkinManager(FOwner).ConstData.Sections[ssMenuCaption] < 0 then
    i := TsSkinManager(FOwner).ConstData.Sections[ssToolBar]
  else
    i := TsSkinManager(FOwner).ConstData.Sections[ssMenuCaption];

  BitBltBorder(ItemBmp.Canvas.Handle, 0, 0, ItemBmp.Width, ItemBmp.Height, BG.Canvas.Handle, aRect.Left + Offset, aRect.Top + Offset, 1);
  if TsSkinManager(FOwner).IsValidSkinIndex(i) then
    PaintItem(i, MakeCacheInfo(BG, 4, 4), True, 0, R, Point(aRect.Left + ExtraWidth(mi), aRect.Top), ItemBmp.Canvas.Handle, FOwner);

  // Text writing
  UpdateFont(ItemBmp.Canvas, Item, False, True);

  s := ExtractWord(1, Item.Caption, [cLineCaption]);
  if cMenuCaption <> CharMinus then
    s := ExtractWord(1, s, [cMenuCaption]);

  Flags := DT_WORDBREAK{DT_SINGLELINE} or DT_VCENTER or DT_CENTER or DT_HIDEPREFIX;
  R := Rect(ExtraWidth(mi), 0, ItemBmp.Width, ItemBmp.Height);
  InflateRect(R, 0, -Margin -2);
  acWriteTextEx(ItemBmp.Canvas, PacChar(s), True, R, Flags, i, False);
  BitBlt(ACanvas.Handle, aRect.Left, aRect.Top, ItemBmp.Width, ItemBmp.Height, ItemBmp.Canvas.Handle, 0, 0, SrcCopy);
  FreeAndNil(ItemBmp);
end;


procedure TsSkinableMenus.SetCaptionFont(const Value: TFont);
begin
  FCaptionFont.Assign(Value);
end;


type
  TAccessProvider = class(TsSkinProvider);


procedure TsSkinableMenus.sAdvancedDrawLineItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
var
{$IFDEF TNTUNICODE}
  ws: WideString;
{$ENDIF}
  Bmp: TBitmap;
  ci: TCacheInfo;
  R, gRect: TRect;
  Item: TMenuItem;
  Flags: cardinal;
  i, l, t: integer;
  sp: TAccessProvider;
  ItemSelected: boolean;
  Images: TCustomImageList;
  DrawData: TacDrawGlyphData;

  function TextRect: TRect;
  begin
    Result := aRect;
    inc(Result.Left, Margin);
    dec(Result.Right, Margin);
  end;

  function ShortCutRect: TRect;
  begin
    Result := aRect;
    Result.Left := WidthOf(TextRect);
  end;

begin
  if (Self = nil) or (FOwner = nil) then
    inherited
  else begin
    Item := TMenuItem(Sender);
    sp := TAccessProvider(MenuProvider);
    if sp = nil then
      try
        sp := TAccessProvider(SendAMessage(Item.GetParentMenu.WindowHandle, AC_GETPROVIDER));
      except
      end;

    if (sp = nil) and (MDISkinProvider <> nil) then
      sp := TAccessProvider(MDISkinProvider);

    if sp = nil then
      inherited
    else
      if sp.SkinData.FCacheBmp <> nil then begin
        // Calc rectangle for painting and defining a Canvas
        Bmp := CreateBmp32(aRect);
        gRect := MkRect(Bmp);
        // BG for menu item
        CI := MakeCacheInfo(sp.MenuLineBmp);
        // Calc real offset to menu item in cache
        if ACanvas = sp.SkinData.FCacheBmp.Canvas then begin // If paint in form cache
          if sp.BorderForm <> nil then
            t := aRect.Top - sp.CaptionHeight(True) - sp.ShadowSize.Top
          else
            if GetWindowLong(sp.Form.Handle, GWL_STYLE) and WS_CAPTION <> 0 then
              t := aRect.Top - SysCaptHeight(sp.Form) - SysBorderWidth(sp.Form.Handle, sp.BorderForm, False)
            else
              t := 0;

          l := aRect.Left - sp.ShadowSize.Left - SysBorderWidth(sp.Form.Handle, sp.BorderForm);
        end
        else begin // If procedure was called by system (DRAWITEM)
          if sp.BorderForm <> nil then
            t := aRect.Top - sp.CaptionHeight(True) + DiffTitle(sp.BorderForm) + integer(sp.FSysExHeight) * 4
          else
            if GetWindowLong(sp.Form.Handle, GWL_STYLE) and WS_CAPTION <> 0 then
              t := aRect.Top - SysCaptHeight(sp.Form) + DiffTitle(sp.BorderForm) - SysBorderWidth(sp.Form.Handle, sp.BorderForm, False)
            else
              t := 0;

          l := aRect.Left - SysBorderWidth(sp.Form.Handle, sp.BorderForm) + DiffBorder(sp.BorderForm);
        end;
        // Skin index for menu item
        i := TsSkinManager(FOwner).ConstData.MenuItem.SkinIndex;
        ItemSelected := Item.Enabled and ((odSelected in State) or (odHotLight in State));
        if TsSkinManager(FOwner).IsValidSkinIndex(i) then
          PaintItem(i, ci, True, integer(ItemSelected), gRect, Point(l, t), Bmp, FOwner);

        gRect.Left := 0;
        gRect.Right := 0;
        Images := nil;
        if not Item.Bitmap.Empty then begin
          gRect.Top := (HeightOf(ARect) - GlyphSize(Item, False).cy) div 2;
          if SysLocale.MiddleEast and (Item.GetParentMenu.BiDiMode = bdRightToLeft) then
            gRect.Left := Bmp.Width - 3 - Item.Bitmap.Width
          else
            gRect.Left := 3;

          gRect.Right := gRect.Left + Item.Bitmap.Width + 3;
          if not Item.Enabled then
            OffsetRect(gRect, -gRect.Left + 3, -gRect.Top + 1);
        
          Bmp.Canvas.Draw(gRect.Left, gRect.Top, Item.Bitmap);
        end
        else begin
          Images := Item.GetImageList;
          if (Item.GetImageList <> nil) and (Item.ImageIndex >= 0) then begin
            gRect.Top := (HeightOf(ARect) - Item.GetImageList.Height) div 2;

            if SysLocale.MiddleEast and (Item.GetParentMenu.BiDiMode = bdRightToLeft) then
              gRect.Left := Bmp.Width - 3 - Item.GetImageList.Width
            else
              gRect.Left := 3;

            gRect.Right := gRect.Left + Item.GetImageList.Width + 3;
          end
          else
            gRect.Right := gRect.Left;
        end;
        if gRect.Right <> gRect.Left then begin
          DrawData.Blend := 0;
          DrawData.SkinIndex := i;
          DrawData.SkinManager := sp.SkinData.SkinManager;
          if (Item.Bitmap <> nil) and (Item.Bitmap.Height <> 0) then
            DrawData.NumGlyphs := max(1, Item.Bitmap.Width div Item.Bitmap.Height)
          else
            if Images <> nil then
              DrawData.NumGlyphs := max(1, Images.Width div Images.Height);

          DrawData.ImageIndex := Item.ImageIndex;
          DrawData.CurrentState := integer(ItemSelected);
          DrawData.Down := False;
          DrawData.Grayed := DrawData.SkinManager.Effects.DiscoloredGlyphs;
          DrawData.Enabled := Item.Enabled;
          DrawData.Reflected := False;
          DrawData.Glyph := nil;
          DrawData.DstBmp := Bmp;
          DrawData.ImgRect := gRect;
          DrawData.Canvas := Bmp.Canvas;
          if DrawData.SkinManager.IsValidSkinIndex(DrawData.ImageIndex) then
            DrawData.BGColor := DrawData.SkinManager.gd[DrawData.ImageIndex].Props[0].Color
          else
            DrawData.BGColor := $FFFFFF;

          DrawData.Images := Images;
          DrawData.Glyph := Item.Bitmap;
          DrawData.DisabledGlyphKind := [dgBlended];
          acDrawGlyphEx(DrawData);
        end;

        // Text writing
        UpdateFont(Bmp.Canvas, Item, odDefault in State);
        R := TextRect;
        if SysLocale.MiddleEast and (Item.GetParentMenu.BiDiMode = bdRightToLeft) then
          R.Left := R.Left - WidthOf(gRect)
        else
          R.Left := R.Left + WidthOf(gRect);

        if Bmp <> nil then
          OffsetRect(R, -TextRect.Left + 2, -R.Top);

        i := TsSkinManager(FOwner).ConstData.Sections[ssMenuLine];
        Flags := DT_CENTER or DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER or DT_NOCLIP;
        if sp.Form.UseRightToLeftReading then
          Flags := Flags or DT_RTLREADING;

        if odNoAccel in State then
          Flags := Flags + DT_HIDEPREFIX;
{$IFDEF TNTUNICODE}
        if Sender is TTntMenuItem then begin
          ws := WideString(TTntMenuItem(Sender).Caption);
          sGraphUtils.WriteTextExW(Bmp.Canvas, PWideChar(ws), True, R, Flags or AlignToInt[Alignment], i, ItemSelected, FOwner);
        end
        else
{$ENDIF}
          if sp.BorderForm <> nil then
{$IFDEF TNTUNICODE}
            sGraphUtils.WriteTextEx(Bmp.Canvas, PChar(Item.Caption), True, R, Flags or AlignToInt[Alignment], i, ItemSelected, FOwner)
{$ELSE}
            WriteText32(Bmp, PacChar(Item.Caption), True, R, Flags or AlignToInt[Alignment], i, ItemSelected, FOwner{$IFDEF TNTUNICODE}, True{$ENDIF})
{$ENDIF}
          else
            sGraphUtils.WriteTextEx(Bmp.Canvas, PChar(Item.Caption), True, R, Flags or AlignToInt[Alignment], i, ItemSelected, FOwner);

        if Assigned(FOnDrawItem) then
          FOnDrawItem(Item, Bmp.Canvas, gRect, State, smTopLine);

        if Assigned(Bmp) then begin
          if not Item.Enabled then begin
            R := Rect(l, t, l + Bmp.Width, t + Bmp.Width);
            SumBmpRect(Bmp, sp.MenuLineBmp, DefBlendDisabled, R, MkPoint);
          end;
          BitBlt(ACanvas.Handle, aRect.Left, aRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
          FreeAndNil(Bmp);
        end;
      end;
  end;
end;


procedure TsSkinableMenus.sMeasureLineItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
var
  W: integer;
  Menu: TMenu;
  Text: acString;
  Item: TMenuItem;
begin
  Item := TMenuItem(Sender);
  Height := GetSystemMetrics(SM_CYMENU) - 1;

  UpdateFont(ACanvas, Item, False);
  Text := ReplaceStr(Item.Caption, '&', '');
  W := ACanvas.TextWidth(Text);
  Menu := Item.GetParentMenu;
  if Assigned(Menu.Images) and (Item.ImageIndex >= 0) then
    inc(W, Menu.Images.Width + 6)
  else
    if not Item.Bitmap.Empty then
      inc(W, Item.Bitmap.Width + 6);

  // If last item (for a MDIChild buttons drawing)
  if LastItem(Item) then
    inc(W, 40);

  Width := W;
end;


procedure TsSkinableMenus.InitItem(Item: TMenuItem; A: boolean);
begin
  if A then
    if not IsTopLine(Item) then begin
      if TsSkinManager(FOwner).SkinnedPopups then begin
        if not Assigned(Item.OnAdvancedDrawItem) then
          Item.OnAdvancedDrawItem := sAdvancedDrawItem;

        if not Assigned(Item.OnMeasureItem) then
          Item.OnMeasureItem := sMeasureItem;
      end;
    end
    else begin
      Item.OnAdvancedDrawItem := sAdvancedDrawLineItem;
      Item.OnMeasureItem := sMeasureLineItem;
    end
  else begin
    if addr(Item.OnAdvancedDrawItem) = addr(TsSkinableMenus.sAdvancedDrawItem) then
      Item.OnAdvancedDrawItem := nil;

    if addr(Item.OnMeasureItem) = addr(TsSkinableMenus.sMeasureItem) then
      Item.OnMeasureItem := nil;
  end;
end;


procedure TsSkinableMenus.InitMenuLine(Menu: TMainMenu; A: boolean);
var
  i: integer;
begin
  if Assigned(Menu) and not (csDestroying in Menu.ComponentState) then begin
    for i := 0 to Menu.Items.Count - 1 do
      if A then begin
        if TsSkinManager(FOwner).Active then begin
          if not TsSkinManager(FOwner).SkinnedPopups then
            Exit;

          Menu.Items[i].OnAdvancedDrawItem := sAdvancedDrawLineItem;
          Menu.Items[i].OnMeasureItem := sMeasureLineItem;
        end;
      end
      else begin
        if addr(Menu.Items[i].OnAdvancedDrawItem) = addr(TsSkinableMenus.sAdvancedDrawLineItem) then
          Menu.Items[i].OnAdvancedDrawItem := nil;

        if addr(Menu.Items[i].OnMeasureItem) = addr(TsSkinableMenus.sMeasureLineItem) then
          Menu.Items[i].OnMeasureItem := nil;
      end;

    if Menu.Items.Count > 0 then
      Menu.OwnerDraw := A;
  end;
end;


procedure TsSkinableMenus.HookPopupMenu(Menu: TPopupMenu; Active: boolean);
var
  i: integer;

  procedure HookSubItems(Item: TMenuItem);
  var
    i: integer;
  begin
    for i := 0 to Item.Count - 1 do begin
      if Active then begin
        if not Assigned(Item.Items[i].OnAdvancedDrawItem) then
          Item.Items[i].OnAdvancedDrawItem := sAdvancedDrawItem;

        if not Assigned(Item.Items[i].OnMeasureItem) then
          Item.Items[i].OnMeasureItem := sMeasureItem;
      end
      else begin
        if addr(Item.Items[i].OnAdvancedDrawItem) = addr(TsSkinableMenus.sAdvancedDrawItem) then
          Item.Items[i].OnAdvancedDrawItem := nil;

        if addr(Item.Items[i].OnMeasureItem) = addr(TsSkinableMenus.sMeasureItem) then
          Item.Items[i].OnMeasureItem := nil;
      end;
      HookSubItems(Item.Items[i]);
    end;
  end;

begin
  Menu.OwnerDraw := Active and TsSkinManager(Self.FOwner).SkinnedPopups;
  if Active then
    Menu.MenuAnimation := Menu.MenuAnimation + [maNone]
  else
    Menu.MenuAnimation := Menu.MenuAnimation - [maNone];

  for i := 0 to Menu.Items.Count - 1 do begin
    if Active then begin
      if not Assigned(Menu.Items[i].OnAdvancedDrawItem) then
        Menu.Items[i].OnAdvancedDrawItem := sAdvancedDrawItem;

      if not Assigned(Menu.Items[i].OnMeasureItem) then
        Menu.Items[i].OnMeasureItem := sMeasureItem;
    end
    else begin
      if addr(Menu.Items[i].OnAdvancedDrawItem) = addr(TsSkinableMenus.sAdvancedDrawItem) then
        Menu.Items[i].OnAdvancedDrawItem := nil;

      if addr(Menu.Items[i].OnMeasureItem) = addr(TsSkinableMenus.sMeasureItem) then
        Menu.Items[i].OnMeasureItem := nil;
    end;
    HookSubItems(Menu.Items[i]);
  end;
end;


function TsSkinableMenus.LastItem(Item: TMenuItem): boolean;
begin
  Result := False;
end;


function TsSkinableMenus.IsPopupItem(Item: TMenuItem): boolean;
begin
  Result := Item.GetParentMenu is TPopupMenu;
end;


procedure ClearCache;
begin
  DeleteUnusedBmps(True);
end;


procedure TsSkinableMenus.DrawWndBorder(Wnd: hWnd; MenuBmp: TBitmap);
var
  DC: hdc;
  l, i: integer;
  rgn, subRgn: hrgn;
begin
  if not BorderDrawing then
    if IsNT and (MenuBmp <> nil) and (SendMessage(Wnd, SM_ALPHACMD, AC_UPDATING_HI, 0) = 0) then begin
      SendMessage(Wnd, SM_ALPHACMD, AC_DROPPEDDOWN shl 16, 0);
      BorderDrawing := True;
      l := Length(ArOR);
      rgn := CreateRectRgn(0, 0, MenuBmp.Width, MenuBmp.Height);
      if l > 0 then
        for i := 0 to l - 1 do begin
          subrgn := CreateRectRgn(ArOR[i].Left, ArOR[i].Top, ArOR[i].Right, ArOR[i].Bottom);
          CombineRgn(rgn, rgn, subrgn, RGN_DIFF);
          DeleteObject(subrgn);
        end
      else begin
        subrgn := CreateRectRgn(0, 0, 1, 1);
        CombineRgn(rgn, rgn, subrgn, RGN_DIFF);
        DeleteObject(subrgn);
      end;
      SetWindowRgn(Wnd, rgn, True);
      // Draw border (fix for Extraline)
      DC := GetWindowDC(Wnd);
      BitBltBorder(DC, 0, 0, MenuBmp.Width, MenuBmp.Height, MenuBmp.Canvas.Handle, 0, 0, 3);
      ReleaseDC(Wnd, DC);
      BorderDrawing := False;
    end;
end;


function TsSkinableMenus.GetSkinBorderWidth: integer;
var
  i: integer;
begin
  if FSkinBorderWidth < 0 then begin
    i := TsSkinManager(FOwner).GetMaskIndex(s_MainMenu, s_BordersMask);
    if i >= 0 then begin
      FSkinBorderWidth := TsSkinManager(FOwner).ma[i].BorderWidth;
      if FSkinBorderWidth <= 0 then
        FSkinBorderWidth := 3;
    end
    else
      FSkinBorderWidth := 0;
  end;
  Result := FSkinBorderWidth;
end;


function TsSkinableMenus.ExtraWidth(const mi: TacMenuInfo): integer;
begin
  if TsSkinManager(FOwner).MenuSupport.UseExtraLine and mi.HaveExtraLine then
    Result := TsSkinManager(FOwner).MenuSupport.ExtraLineWidth
  else
    Result := 0;
end;


function TsSkinableMenus.GetItemWidth(aCanvas: TCanvas; Item: TMenuItem; const mi: TacMenuInfo): integer;
var
  Text: string;
  R: TRect;
begin
  UpdateFont(ACanvas, Item, Item.Default);
  case it of
    smDivider:
      Result := Margin * 3 + ACanvas.TextWidth(Text) + GlyphSize(Item, False).cx * 2 + Spacing;

    smCaption: begin
      Text := cLineCaption + Item.Caption + cLineCaption;
      Result := Margin * 3 + ACanvas.TextWidth(Text) + GlyphSize(Item, False).cx * 2 + Spacing;
    end

    else begin
      Text := Item.Caption + iff(ShortCutToText(Item.ShortCut) = '', '', ShortCutToText(Item.ShortCut));
      R := MkRect(1, 0);
      DrawText(ACanvas.Handle, PChar(Text), Length(Text), R, DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP or DT_CALCRECT);
      Result := WidthOf(R) + Margin * 3 + GlyphSize(Item, False).cx * 2 + Spacing;
    end;
  end;
  if mi.HaveExtraLine then
    inc(Result, ExtraWidth(mi));
end;


function TsSkinableMenus.ParentWidth(aCanvas: TCanvas; Item: TMenuItem): integer;
var
  i, OldRes, w, h: integer;
  it: TMenuItem;
  R: TRect;
begin
  Result := 0;
  OldRes := 0;
  if GetClipBox(aCanvas.Handle, R) <> NULLREGION then
    Result := WidthOf(R)
  else begin
    for i := 0 to Item.Parent.Count - 1 do
      if Item.Parent.Items[i].Visible then begin
        it := Item.Parent.Items[i];
        if it.Break <> mbNone then begin
          inc(OldRes, Result + 4);
          Result := 0;
        end;
        w := 0;
        h := 0;
        sMeasureItem(it, aCanvas, w, h);
        Result := max(Result, w + 12);
      end;

    inc(Result, OldRes);
  end;
end;


function TsSkinableMenus.PrepareMenuBG(Item: TMenuItem; Width, Height: integer; Wnd: hwnd = 0): TBitmap;
var
  i, j, w, Marg: integer;
  VertFont: TLogFont;
  ItemBmp: TBitmap;
  pFont: PLogFontA;
  R, gRect: TRect;
  mi: TacMenuInfo;
  f: TCustomForm;
  CI: TCacheInfo;

  procedure MakeVertFont(Orient: integer);
  begin
    with TsSkinManager(FOwner) do begin
      ItemBmp.Canvas.Font.Assign(MenuSupport.ExtraLineFont);
      f := GetOwnerForm(Item.GetParentMenu);
      if f <> nil then
        ItemBmp.Canvas.Font.Charset := f.Font.Charset;

      pFont := PLogFontA(@VertFont);
      StrPCopy(VertFont.lfFaceName, MenuSupport.ExtraLineFont.Name);
      GetObject(ItemBmp.Canvas.Handle, SizeOf(TLogFont), pFont);
      VertFont.lfEscapement := Orient;
      VertFont.lfHeight     := MenuSupport.ExtraLineFont.Height;
      VertFont.lfStrikeOut  := integer(fsStrikeOut  in MenuSupport.ExtraLineFont.Style);
      VertFont.lfItalic     := integer(fsItalic     in MenuSupport.ExtraLineFont.Style);
      VertFont.lfUnderline  := integer(fsUnderline	in MenuSupport.ExtraLineFont.Style);

      if fsBold in MenuSupport.ExtraLineFont.Style then
        VertFont.lfWeight := FW_BOLD
      else
        VertFont.lfWeight := FW_NORMAL;

      VertFont.lfCharSet         := MenuSupport.ExtraLineFont.Charset;
      VertFont.lfWidth           := 0;
      Vertfont.lfOutPrecision    := OUT_DEFAULT_PRECIS;
      VertFont.lfClipPrecision   := CLIP_DEFAULT_PRECIS;
      VertFont.lfOrientation     := VertFont.lfEscapement;
      VertFont.lfPitchAndFamily  := Default_Pitch;
      VertFont.lfQuality         := ANTIALIASED_QUALITY;//Default_Quality;
      ItemBmp.Canvas.Font.Handle := CreateFontIndirect(VertFont);
      ItemBmp.Canvas.Font.Color  := gd[j].Props[0].FontColor.Color;
    end;
  end;

begin
  Result := nil;
  with TsSkinManager(FOwner) do begin
    if not (csDesigning in ComponentState) then
      if Item.Parent.Items[0].Name <> s_SkinSelectItemName then begin
        ExtraSection := s_MenuExtraLine;
        if ExtraGlyph <> nil then
          FreeAndNil(ExtraGlyph);

        ExtraCaption := DontForget;
        mi.HaveExtraLine := True;
        if Assigned(OnGetMenuExtraLineData) then
          OnGetMenuExtraLineData(Item.Parent.Items[0], ExtraSection, ExtraCaption, ExtraGlyph, mi.HaveExtraLine);

        ExtraCaption := DelChars(ExtraCaption, '&');
        if not mi.HaveExtraLine and Assigned(ExtraGlyph) then
          FreeAndNil(ExtraGlyph);
      end
      else
        mi.HaveExtraLine := False;

    mi.FirstItem := Item.Parent.Items[0];
    mi.Wnd := Wnd;
    mi.Bmp := CreateBmp32(Width, Height);
    mi.Bmp.Canvas.Lock;
    mi.ItemsIterated := False;
    gRect := MkRect(Width, Height);
    i := ConstData.Sections[ssMainMenu];
    // Draw Menu
    GlyphSizeCX := GlyphSize(Item, false).cx;
    IcoLineWidth := GlyphSizeCX + Margin + Spacing;
    if IsValidSkinIndex(i) then begin
      // Background
      PaintItemBG(i, EmptyCI, 0, gRect, MkPoint, mi.Bmp, FOwner);
      ci := MakeCacheInfo(mi.Bmp);
      // Ico line painting
      if GetWindowLong(Item.GetParentMenu.WindowHandle, GWL_EXSTYLE) and WS_EX_RIGHT = 0 then begin
        j := GetSkinIndex(MenuSupport.IcoLineSkin);
        if j >= 0 then begin // Ico line
          ItemBmp := CreateBmp32(IcoLineWidth, Mi.Bmp.Height - SkinBorderWidth * 2);
          PaintItem(j, ci, True, 0, MkRect(ItemBmp), Point(SkinBorderWidth + ExtraWidth(mi), SkinBorderWidth), ITemBmp, FOwner);
          BitBlt(mi.Bmp.Canvas.Handle, SkinBorderWidth + ExtraWidth(mi), SkinBorderWidth, ItemBmp.Width, ItemBmp.Height, ItemBmp.Canvas.Handle, 0, 0, SrcCopy);
          FreeAndNil(ItemBmp);
        end;
      end;                     
      // Border
      j := gd[i].BorderIndex;// GetMaskIndex(i, s_BordersMask);
      if IsValidImgIndex(j) then
        DrawSkinRect(mi.Bmp, gRect, {False, }MakeCacheInfo(mi.Bmp), ma[j], 0, False);
      // Extra line painting
      if MenuSupport.UseExtraLine and mi.HaveExtraLine then begin
        j := GetSkinIndex(ExtraSection);
        if j >= 0 then begin // Extra line
          ItemBmp := CreateBmp32(MenuSupport.ExtraLineWidth, mi.Bmp.Height - SkinBorderWidth * 2);
          R := MkRect(ItemBmp);
          PaintItem(j, ci, True, 0, R, Point(SkinBorderWidth, SkinBorderWidth), ItemBmp, FOwner);
          Marg := 12;
          if ExtraGlyph <> nil then begin
            inc(Marg, ExtraGlyph.Height + 8);
            ItemBmp.Canvas.Draw((ItemBmp.Width - ExtraGlyph.Width) div 2, ItemBmp.Height - 12 - ExtraGlyph.Height, ExtraGlyph);
          end;
          if ExtraCaption <> '' then begin
            MakeVertFont(-2700);
            w := ItemBmp.Canvas.TextHeight(ExtraCaption);
            ItemBmp.Canvas.Brush.Style := bsClear;
            ItemBmp.Canvas.TextRect(R, R.Left + (WidthOf(R) - w) div 2, ItemBmp.Height - Marg, ExtraCaption);
          end;
          BitBlt(mi.Bmp.Canvas.Handle, SkinBorderWidth, SkinBorderWidth, ItemBmp.Width, ItemBmp.Height, ItemBmp.Canvas.Handle, 0, 0, SrcCopy);
          FreeAndNil(ItemBmp);
        end;
        if Assigned(ExtraGlyph) then
          FreeAndNil(ExtraGlyph);
      end;
      if SysLocale.MiddleEast and (Item.GetParentMenu.BiDiMode <> bdLeftToRight) then // Flip BG
        StretchBlt(mi.Bmp.Canvas.Handle, mi.Bmp.Width, 0, -mi.Bmp.Width, mi.Bmp.Height,
                   mi.Bmp.Canvas.Handle, 0, 0, mi.Bmp.Width, mi.Bmp.Height, SRCCOPY);
      // Prepare array of trans. px
      SetLength(ArOR, 0);
      i := GetMaskIndex(i, s_BordersMask);
      if IsValidImgIndex(i) then begin
        AddRgn(ArOR, mi.Bmp.Width, ma[i], 0, False);
        AddRgn(ArOR, mi.Bmp.Width, ma[i], mi.Bmp.Height - ma[i].WB, True);
      end;
      if Wnd <> 0 then
        DrawWndBorder(Wnd, mi.Bmp);
    end;
    mi.Bmp.Canvas.UnLock;
    SetLength(MenuInfoArray, Length(MenuInfoArray) + 1);
    MenuInfoArray[Length(MenuInfoArray) - 1] := mi;
  end;
end;


function TsSkinableMenus.GetMenuInfo(Item: TMenuItem; const aWidth, aHeight: integer; aCanvas: TCanvas; aWnd: hwnd = 0): TacMenuInfo;
var
  i, l, w, h: integer;
  fi: TMenuItem;
  R: TRect;
begin
  Result.FirstItem := nil;
  Result.Bmp := nil;
  l := Length(MenuInfoArray);
  if Item <> nil then begin
    fi := Item.Parent.Items[0];
    for i := 0 to l - 1 do
      if MenuInfoArray[i].FirstItem = fi then begin
        // Found
        Result := MenuInfoArray[i];
        Exit;
      end;

    // If not found but BG is required already
    if aCanvas <> nil then begin
      if aWnd <> 0 then
        if GetWindowRect(aWnd, R) then begin
          w := WidthOf(R, True);
          h := HeightOf(R, True);
        end
        else begin
          w := 0;
          h := 0;
        end
      else begin
        w := ParentWidth(ACanvas, Item) + BorderWidth * 2{ + 4} {Fix for some systems where Wnd = 0};
        h := ParentHeight(ACanvas, Item) + BorderWidth * 2;
      end;
      PrepareMenuBG(fi, W, H, aWnd);
      Result := GetMenuInfo(fi, 0, 0, nil);
    end;
  end
  else
    if aWnd <> 0 then
      for i := 0 to l - 1 do
        if MenuInfoArray[i].Wnd = aWnd then begin
          Result := MenuInfoArray[i];
          Exit;
        end;
end;
{$ENDIF}


constructor TacMenuSupport.Create;
begin
  FUseExtraLine := False;
  FExtraLineWidth := 32;
  FExtraLineFont := TFont.Create;
  FAlphaBlend := MaxByte;
  FFont := TFont.Create;
end;


destructor TacMenuSupport.Destroy;
begin
  FreeAndNil(FExtraLineFont);
  FreeAndNil(FFont);
  if CustomFont then
    FreeAndNil(CustomMenuFont);

  inherited;
end;


function TacMenuSupport.ExtraFontStored: boolean;
var
  f: TFont;
begin
  F := TFont.Create;
  Result := not FontsEqual(F, FExtraLineFont);
  F.Free;
end;


function TacMenuSupport.FontStored: boolean;
var
  f: TFont;
begin
  F := TFont.Create;
  Result := not FontsEqual(F, FFont);
  F.Free;
end;


function TacMenuSupport.LineSkinStored: boolean;
begin
  Result := FIcoLineSkin <> s_MenuIcoLine;
end;


procedure TacMenuSupport.SetCustomFont(const Value: boolean);
begin
  FCustomFont := Value;
  if Value then begin
    if CustomMenuFont = nil then
      CustomMenuFont := TFont.Create;

    CustomMenuFont.Assign(Font);
  end
  else
    FreeAndNil(CustomMenuFont);
end;


procedure TacMenuSupport.SetExtraLineFont(const Value: TFont);
begin
  FExtraLineFont.Assign(Value);
end;


procedure TacMenuSupport.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  if CustomMenuFont = nil then
    CustomMenuFont := TFont.Create;

  CustomMenuFont.Assign(Font);
end;


{$IFNDEF FPC}
initialization

finalization
  ClearCache;
{$ENDIF}

end.
