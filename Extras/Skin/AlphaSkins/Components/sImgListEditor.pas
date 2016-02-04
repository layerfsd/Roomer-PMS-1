unit sImgListEditor;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, ActnList, Buttons, ImgList, ExtDlgs,
  {$IFDEF DELPHI_XE2}UITypes, {$ENDIF}
  sPanel, sSpeedButton, acAlphaImageList, sSkinProvider, sListView, sBitBtn, sButton,
  sEdit;


type
  TFormImgListEditor = class(TForm)
    sBitBtn5: TsBitBtn;
    sBitBtn6: TsBitBtn;
    sBitBtn7: TsBitBtn;
    ImageList1: TsAlphaImageList;
    OpenPictureDialog1: TOpenPictureDialog;
    ListView1: TsListView;
    SpeedButton1: TsSpeedButton;
    SpeedButton2: TsSpeedButton;
    SpeedButton3: TsSpeedButton;
    SpeedButton4: TsSpeedButton;
    sSkinProvider1: TsSkinProvider;
    sAlphaImageList1: TsAlphaImageList;
    SaveDialog1: TSaveDialog;
    SpeedButton5: TsSpeedButton;
    SpeedButton6: TsSpeedButton;
    sEdit1: TsEdit;
    procedure ListView1DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ListView1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure sBitBtn5Click(Sender: TObject);
    procedure sBitBtn6Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sBitBtn7Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure CheckScroll(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure sEdit1Change(Sender: TObject);
  public
    sImageList: TsAlphaImageList;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DropFiles;
    procedure ListViewRefresh;
    procedure InitFromImgList(ImgList: TsAlphaImageList);
  end;


var
  FormImgListEditor: TFormImgListEditor;
  ScrollTimer: TTimer = nil;


implementation

uses
  CommCtrl, ShellAPI,
  {$IFNDEF ALITE}acPathDialog, sDialogs, {$ELSE}FileCtrl, {$ENDIF}
  acntUtils, sConst, sVCLUtils, sGraphUtils, sAlphaGraph;

{$R *.DFM}

const
  scBorder = 8;


procedure StartScroll;
begin
  if ScrollTimer = nil then begin
    ScrollTimer := TTimer.Create(nil);
    ScrollTimer.OnTimer := FormImgListEditor.CheckScroll;
    ScrollTimer.Interval := 10;
  end;
end;


procedure EndScroll;
begin
  if ScrollTimer <> nil then
    FreeAndNil(ScrollTimer);
end;


procedure DoScroll(X, Y: integer);
var
  dx: integer;
begin
  if X > FormImgListEditor.ListView1.Width - scBorder then
    dx := 10
  else
    if X < scBorder then
      dx := -10
    else
      dx := 0;

  if (dx <> 0) then begin
    FormImgListEditor.ListView1.Scroll(dx, 0);
    FormImgListEditor.ListView1.Invalidate;
  end;
end;


procedure TFormImgListEditor.InitFromImgList(ImgList: TsAlphaImageList);
begin
  ImageList1.DoubleData := True;
  ImageList1.AcBeginUpdate;
  ImageList1.Clear;
  ImageList1.Items.Clear;

  sImageList := ImgList;
  Caption := ImgList.Owner.Name + s_Dot + ImgList.GetNamePath;

  ImageList1.Width := ImgList.Width;
  ImageList1.Height := ImgList.Height;

  ImageList_SetBkColor(ImageList1.Handle, ColorToRGB(ListView1.Color));

  ImageList1.CopyImages(ImgList);

  ImageList1.AcEndUpdate;
  ListViewRefresh;
end;


procedure TFormImgListEditor.ListView1DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  li: TListItem;
begin
  li := ListView1.GetItemAt(X, Y);
  Accept := (li <> nil) and (li <> ListView1.ItemFocused);
  if (X < scBorder) or (X > ListView1.Width - scBorder) then
    StartScroll
end;


procedure TFormImgListEditor.ListView1DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  li: TListItem;
begin
  li := ListView1.GetItemAt(X, Y);
  ImageList1.Items[ListView1.ItemFocused.Index].Index := li.Index;
  ImageList1.Move(ListView1.ItemFocused.Index, li.Index);
  EndScroll;
end;


procedure TFormImgListEditor.ListViewRefresh;
var
  i: integer;
begin
  SendMessage(ListView1.Handle, WM_SETREDRAW, 0, 0);
  ListView1.Items.Clear;
  for i := 0 to ImageList1.Count - 1 do begin
    ListView1.Items.Add.Selected;
    ListView1.Items.Item[i].ImageIndex := i;
    ListView1.Items.Item[i].Caption := IntToStr(i);
  end;
  SendMessage(ListView1.Handle, WM_SETREDRAW, 1, 0);
  SpeedButton3.Enabled := ImageList1.Count > 0;
  SpeedButton4.Enabled := ImageList1.Count > 0;
end;


procedure TFormImgListEditor.FormShow(Sender: TObject);
begin
  DragAcceptFiles(Handle, True);
  ListView1.Height := ImageList1.Height + GetFontHeight(ListView1.Font.Handle) + GetSystemMetrics(SM_CYVSCROLL) + 8;

  Height := 124 + ListView1.Height;
  Constraints.MinHeight := Height;
//  sBitBtn7.Top := ListView1.BoundsRect.Top;//Bottom - sBitBtn7.Height + 19;
//  sBitBtn6.Top := sBitBtn7.Top - sBitBtn6.Height - 4;
//  sBitBtn5.Top := sBitBtn6.Top - sBitBtn5.Height - 4;

  ListView1.Anchors := ListView1.Anchors + [akBottom, akRight];
  sBitBtn5.Anchors := sBitBtn5.Anchors + [akRight] - [akLeft];
  sBitBtn6.Anchors := sBitBtn6.Anchors + [akRight] - [akLeft];
  sBitBtn7.Anchors := sBitBtn7.Anchors + [akRight] - [akLeft];

  sEdit1.Top := ListView1.BoundsRect.Bottom + 8;
  sEdit1.Width := ListView1.BoundsRect.Right - 72;

end;


procedure TFormImgListEditor.ListView1Click(Sender: TObject);
begin

{$IFDEF DELPHI7UP}
  SpeedButton2.Enabled := ListView1.ItemIndex > -1;
  if ListView1.ItemIndex > -1 then
    sEdit1.Text := ImageList1.Items[ListView1.ItemIndex].Text
  else
    sEdit1.Text := '';
{$ELSE}
  SpeedButton2.Enabled := ListView1.Selected <> nil;
  if SpeedButton2.Enabled then
    sEdit1.Text := ImageList1.Items[ListView1.Selected.Index].Text
  else
    sEdit1.Text := '';
{$ENDIF}
  SpeedButton3.Enabled := ImageList1.Count > 0;
  SpeedButton4.Enabled := ImageList1.Count > 0;
  SpeedButton6.Enabled := SpeedButton2.Enabled;
  SpeedButton5.Enabled := SpeedButton2.Enabled;
  sEdit1.Enabled := ImageList1.Count > 0;
end;


procedure TFormImgListEditor.SpeedButton1Click(Sender: TObject);
var
  i: integer;
begin
  if OpenPictureDialog1.Execute then begin
    for i := 0 to OpenPictureDialog1.Files.Count - 1 do
      ImageList1.LoadFromfile(OpenPictureDialog1.Files[i]);

    ListViewRefresh;
  end;
end;


procedure TFormImgListEditor.SpeedButton2Click(Sender: TObject);
var
  i, j: integer;
begin
  if ListView1.Selected <> nil then begin
    i := ListView1.Selected.Index;
    ImageList1.AcBeginUpdate;
{$IFDEF DELPHI7UP}
    ListView1.DeleteSelected;
{$ELSE}
    ListView1.Items.Delete(i);
{$ENDIF}
    ImageList1.Delete(i);
    if i < ImageList1.Items.Count then
      ImageList1.Items.Delete(i);

    if ListView1.Items.Count > 0 then begin
      for j := 0 to ListView1.Items.Count - 1 do begin
        ListView1.Items[j].Caption := IntToStr(j);
        if j >= i then
          ListView1.Items[j].ImageIndex := ListView1.Items[j].ImageIndex - 1;
      end;
      if i > ListView1.Items.Count - 1 then
        i := ListView1.Items.Count - 1;

      ListView1.Selected := ListView1.Items[i];
    end;
    ImageList1.AcEndUpdate;
  end;
end;


procedure TFormImgListEditor.SpeedButton3Click(Sender: TObject);
begin
  if MessageDlg('Do you want to remove all icons?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    ImageList1.AcBeginUpdate;
    ImageList1.Clear;
    ImageList1.Items.Clear;
    ImageList1.AcEndUpdate;
    ListViewRefresh;
    SpeedButton3.Enabled := False;
    SpeedButton4.Enabled := ImageList1.Count > 0;
  end;
end;


procedure TFormImgListEditor.sBitBtn5Click(Sender: TObject);
begin
  if Assigned(sImageList) then begin
    ImageList_SetBkColor(ImageList1.Handle, CLR_NONE);
    sImageList.AcBeginUpdate;
    sImageList.Clear;
    sImageList.CopyImages(ImageList1);
    sImageList.AcEndUpdate;
  end;
  Close;
end;


procedure TFormImgListEditor.sBitBtn6Click(Sender: TObject);
begin
  Close;
end;


procedure TFormImgListEditor.WMDropFiles(var Msg: TWMDropFiles);
const
  maxlen = 254;
var
  h: THandle;
  i, num: integer;
  pchr: array [0..maxlen] of acChar;
  fname: acString;
begin
  h := Msg.Drop;
  num := DragQueryFile(h, Dword(-1), nil, 0);
  if num > 0 then begin
    for i := 0 to num - 1 do begin
{$IFDEF TNTUNICODE}
      DragQueryFileW(h, i, pchr, maxlen);
{$ELSE}
      DragQueryFile(h, i, pchr, maxlen);
{$ENDIF}
      fname := acString(pchr);
      ImageList1.LoadFromfile(fname);
    end;
    ListViewRefresh;
  end;
  DragFinish(h);
end;


procedure TFormImgListEditor.FormDestroy(Sender: TObject);
begin
  DragAcceptFiles(Handle, False);
  EndScroll;
end;


procedure TFormImgListEditor.ListView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 46 then
    SpeedButton2.Click;
end;


procedure TFormImgListEditor.sBitBtn7Click(Sender: TObject);
begin
  if Assigned(sImageList) then begin
    ImageList_SetBkColor(ImageList1.Handle, CLR_NONE);
    sImageList.Assign(ImageList1);
  end;
end;


procedure TFormImgListEditor.SpeedButton4Click(Sender: TObject);
var
  j: integer;
  s, sPath: string;
{$IFNDEF ALITE}
  PathDlg: TsPathDialog;
{$ELSE}
{$ENDIF}
begin
  sPath := '.\';
{$IFNDEF ALITE}
  PathDlg := TsPathDialog.Create(Application);
  PathDlg.Path := sPath;
  PathDlg.Root := 'rfMyComputer';
  PathDlg.ShowRootBtns := True;
  PathDlg.Caption := 'Export glyphs to:';
  if PathDlg.Execute then begin
    sPath := PathDlg.Path;
{$ELSE}
  if SelectDirectory(sPath, [], -1) then begin
{$ENDIF}
    for j := 0 to ListView1.Items.Count - 1 do
      if (ImageList1.Items[j].ImgData <> nil) then begin
        s := iff(ImageList1.Items[j].ImageName <> '', ImageList1.Items[j].ImageName, IntToStr(j));
        ImageList1.Items[j].ImgData.SaveToFile(sPath + s_Slash + s + s_Dot + iff(ImageList1.Items[j].ImageFormat = ifPNG, acPngExt, acIcoExt));
      end
  end;
{$IFNDEF ALITE}
  PathDlg.Free;
{$ENDIF}
end;


procedure TFormImgListEditor.SpeedButton5Click(Sender: TObject);
var
  Index: integer;
  Icon: HICON;
  iFormat: TsImageFormat;
  Bmp: TBitmap;
begin
  if OpenPictureDialog1.Execute then
    if GetImageFormat(OpenPictureDialog1.FileName, iFormat) then begin
      Icon := 0;
{$IFDEF DELPHI7UP}
      Index := ListView1.ItemIndex;
{$ELSE}
      Index := ListView1.Selected.Index;
{$ENDIF}
      if Index < 0 then
        Exit;

      ImageList1.Items[Index].ImageFormat := iFormat;
      ImageList1.Items[Index].ImgData.Clear;
      ImageList1.Items[Index].ImgData.LoadFromFile(OpenPictureDialog1.FileName);
      FreeAndNil(ImageList1.Items[Index].CacheBmp);
      case iFormat of
        ifPNG: begin
          Bmp := TBitmap.Create;
          LoadBmpFromPngFile(Bmp, OpenPictureDialog1.FileName);
          Icon := MakeIcon32(Bmp);
          Bmp.Free;
        end;

        ifICO:
          Icon := {$IFDEF TNTUNICODE}ExtractIconW{$ELSE}ExtractIcon{$ENDIF}(hInstance, PacChar(OpenPictureDialog1.FileName), 0);
      end;
      if Icon <> 0 then begin
        ImageList_ReplaceIcon(ImageList1.Handle, Index, Icon);
        DestroyIcon(Icon);
        ListViewRefresh;
{$IFDEF DELPHI7UP}
        ListView1.ItemIndex := Index;
{$ELSE}
        ListView1.Selected := ListView1.Items[Index];
{$ENDIF}
      end;
    end
    else
      ShowError('Unsupported file format');
end;


procedure TFormImgListEditor.SpeedButton6Click(Sender: TObject);
var
  j: integer;
begin
  if (ListView1.Selected <> nil) then begin
    j := ListView1.Selected.Index;
    if ImageList1.Items[j].ImageFormat = ifPNG then begin
      SaveDialog1.Filter := 'Portable Network Graphics|*.png';
      SaveDialog1.DefaultExt := acPngExt;
    end
    else begin
      SaveDialog1.Filter := 'Icons|*.ico';
      SaveDialog1.DefaultExt := acIcoExt
    end;
    if ImageList1.Items[j].ImageName <> '' then
      SaveDialog1.FileName := ImageList1.Items[j].ImageName
    else
      SaveDialog1.FileName := IntToStr(j);

    if SaveDialog1.Execute then
      ImageList1.Items[j].ImgData.SaveToFile(SaveDialog1.FileName);
  end;
end;


procedure TFormImgListEditor.CheckScroll(Sender: TObject);
var
  P: TPoint;
begin
  if (Mouse.Capture <> 0) and (ScrollTimer <> nil) and not (csDestroying in ScrollTimer.ComponentState) and (FormImgListEditor <> nil) then begin
    ScrollTimer.Enabled := False;
    P := ListView1.ScreenToClient(acMousePos);
    DoScroll(P.X, P.Y);
    if ScrollTimer <> nil then
      ScrollTimer.Enabled := True;
  end;
end;


procedure TFormImgListEditor.sEdit1Change(Sender: TObject);
begin
{$IFDEF DELPHI7UP}
  if ListView1.ItemIndex > -1 then
    ImageList1.Items[ListView1.ItemIndex].Text := sEdit1.Text;
{$ELSE}
  if ListView1.Selected <> nil then
    ImageList1.Items[ListView1.Selected.Index].Text := sEdit1.Text;
{$ENDIF}
end;

end.
