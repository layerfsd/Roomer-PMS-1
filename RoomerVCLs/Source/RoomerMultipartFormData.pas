{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$


  Prior revision history:

  Rev 1.17    2/8/05 6:07:16 PM  RLebeau
    Removed AddToInternalBuffer() method, using new AppendString() function
    from IdGlobal instead

  Rev 1.16    10/26/2004 10:29:30 PM  JPMugaas
    Updated refs.

  Rev 1.15    7/16/04 12:02:16 PM  RLebeau
    Reverted FileName fields to not strip off folder paths anymore.

  Rev 1.14    7/5/04 1:19:06 PM  RLebeau
    Updated IdRead() to check the calculated byte count before copying data
    into the caller's buffer.

  Rev 1.13    5/31/04 9:28:58 PM  RLebeau
    Updated FileName fields to strip off folder paths.
    Added "Content-Transfer-Encoding" header to file fields
    Updated "Content-Type" headers to be the appropriate media types when
    applicable

  Rev 1.12    5/30/04 7:39:02 PM  RLebeau
    Moved FormatField() method from TIdMultiPartFormDataStream to
    TIdFormDataField instead
    Misc. tweaks and bug fixes

  Rev 1.11    2004.05.20 11:37:02 AM  czhower
    IdStreamVCL

  Rev 1.10    3/1/04 8:57:34 PM  RLebeau
    Format() fixes for TIdMultiPartFormDataStream.FormatField() and
    TIdFormDataField.GetFieldSize().

  Rev 1.9    2004.02.03 5:44:08 PM  czhower
    Name changes

  Rev 1.8    2004.02.03 2:12:16 PM  czhower
    $I path change

  Rev 1.7    25/01/2004 21:56:42  CCostelloe
    Updated IdSeek to use new IdFromBeginning

  Rev 1.6    24/01/2004 19:26:56  CCostelloe
    Cleaned up warnings

  Rev 1.5    22/11/2003 12:05:26 AM  GGrieve
    Get working on both win32 and DotNet after other DotNet changes

  Rev 1.4    11/10/2003 8:03:54 PM  BGooijen
    Did all todo's ( TStream to TIdStream mainly )

  Rev 1.3    2003.10.24 10:43:12 AM  czhower
    TIdSTream to dos

  Rev 1.2    10/17/2003 12:49:52 AM  DSiders
    Added localization comments.
    Added resource string for unsupported operation exception.

  Rev 1.1    10/7/2003 10:07:06 PM  GGrieve
    Get HTTP compiling for DotNet

  Rev 1.0    11/13/2002 07:57:42 AM  JPMugaas
    Initial version control checkin.

  2001-Nov-23
    changed spelling error from XxxDataFiled to XxxDataField

  2001-Nov Doychin Bondzhev
    Now it descends from TStream and does not do buffering.
    Changes in the way the form parts are added to the stream.
}

unit RoomerMultipartFormData;

{
  Implementation of the Multipart Form data

  Based on Internet standards outlined in:
    RFC 1867 - Form-based File Upload in HTML
    RFC 2388 - Returning Values from Forms:  multipart/form-data

  Author: Shiv Kumar
}

interface

uses
  Classes,
  IdGlobal,
  IdMultiPartFormData,
  IdResourceStringsProtocols;

type
  TRoomerMultiPartFormData = class;

  TRoomerMultipartFormData = class(TIdMultipartFormDataStream)
  protected
  public
    function AddRoomerFile(const RoomerFilename, AFieldName, AFileName: String; const AContentType: string = ''): TIdFormDataField;
  end;

implementation

function TRoomerMultiPartFormData.AddRoomerFile(const RoomerFilename, AFieldName, AFileName: String;
  const AContentType: string = ''): TIdFormDataField;
var
  LItem: TIdFormDataField;
begin
  Litem := AddFile(AFieldName, AFileName, AContentType);
  with LItem do begin
    FileName := RoomerFilename;
  end;

  Result := LItem;
end;


end.