unit RoomerMathParser;

interface

uses sysutils, stdctrls, classes;

TYPE
  EparserError = class(Exception);

  Rparameters = record
    x, y, z: extended;
  end;

Const
  parameter: Rparameters = (x: 1; y: 1; z: 1);

TYPE

  TRoomerMathEdit = class(TEdit)
  private
    function getEvaluatedString: string;
  public
    property TextValue: string read getEvaluatedString;
  end;

function EvaluateToFloat(s0: string): extended;
Function GetEvaluationError: string;
procedure Register;

implementation

const
  sopps: string = ('+-*/^');

var
  EvaluationError: string;

procedure Register;
begin
  RegisterComponents('Roomer', [TRoomerMathEdit]);
end;
function evaluate(s0: string): extended; forward;

procedure matchbracket(var i: integer; s0: string);
var
  j, len: integer;
begin
  j := 1;
  len := length(s0);
  repeat
    inc(i);
    if i > len then
      raise EparserError.Create('missing '')''');
    if s0[i] = '(' then
      inc(j);
    if s0[i] = ')' then
      dec(j);
    if j < 0 then
      raise EparserError.Create('missing ''(''');
  until j = 0;
end;

function getvalue(s0: string): extended;
begin
  if length(s0) < 1 then
    raise EparserError.Create('syntax error');
  if length(s0) = 1 then
    result := strtofloat(s0)
  else
    case s0[1] of
      'x':
        result := parameter.x;
      'y':
        result := parameter.y;
      'z':
        result := parameter.z;
    else
      result := strtofloat(s0);
    end;
end;

function specialF(p1: integer; s0: string): extended;
var
  operstr: string;
  arg: extended;
begin
  operstr := copy(s0, 1, p1 - 1);
  if s0[length(s0)] <> ')' then
    EparserError.CreateFmt('incorrect syntax %s', [s0]);
  arg := evaluate(copy(s0, p1 + 1, length(s0) - p1 - 1));
  if operstr = 'sin' then
    result := sin(arg)
  else if operstr = 'cos' then
    result := cos(arg)
  else if operstr = 'tan' then
    result := sin(arg) / cos(arg)
  else if operstr = 'arctan' then
    result := arctan(arg)
  else if operstr = 'log' then
    result := ln(arg) / ln(10)
  else if operstr = 'ln' then
    result := ln(arg)
  else if operstr = 'exp' then
    result := exp(arg)
  else if operstr = 'sqrt' then
    result := sqrt(arg)
    { enter additional functions here }
  else
    raise EparserError.CreateFmt('unknown function %s', [s0]);
end;

function calculate(p1: integer; s0: string): extended;
var
  v1, v2: extended;
begin
  v1 := evaluate(copy(s0, 1, p1 - 1));
  v2 := evaluate(copy(s0, p1 + 1, length(s0) - p1));
  case s0[p1] of
    '+':
      result := v1 + v2;
    '-':
      result := v1 - v2;
    '/':
      result := v1 / v2;
    '*':
      result := v1 * v2;
    '^':
      result := exp(v2 * ln(v1));
  else
    raise EparserError.CreateFmt('invalid operation %s', [s0]);
  end;
end;

function getfirstopp(tot: integer; s0: string): integer;
var
  i: integer;
begin
  if tot = 0 then
    tot := length(s0);
  for i := 1 to 5 do
  begin
    result := pos(sopps[i], s0);
    if ((i < 3) and (result > 0)) then
      if ((result = 1) or (pos(s0[result - 1], sopps) > 0)) then
        result := 0;
    if result > 0 then
      if result < tot then
        exit;
  end;
  if result > tot then
    result := 0;
end;

function evaluate(s0: string): extended;
var
  p1, p2, q1: integer;
begin
  p1 := pos('(', s0);
  p2 := p1;
  if p2 > 0 then
    matchbracket(p2, s0);
  if p1 = 1 then
  begin
    if p2 = length(s0) then
    begin
      delete(s0, p2, 1);
      delete(s0, 1, 1);
      result := evaluate(s0);
    end
    else
      result := calculate(p2 + 1, s0);
    exit;
  end;
  q1 := getfirstopp(p1, s0);
  if (p1 + q1 = 0) then
  begin
    result := getvalue(s0);
    exit;
  end;
  if q1 <> 0 then
    result := calculate(q1, s0)
  else if length(s0) > p2 then
    result := calculate(p2 + 1, s0)
  else
    result := specialF(p1, s0);
end;

procedure cleanup(var s0: string);
var
  i: integer;
begin
  s0 := lowercase(s0);
  i := pos(' ', s0);
  while i > 0 do
  begin
    delete(s0, i, 1);
    i := pos(' ', s0);
  end;
end;

function TRoomerMathEdit.getEvaluatedString: string;
var
  s0: string;
begin
  s0 := text;
  TRY
    cleanup(s0);
    result := floattostr(evaluate(s0));
  EXCEPT
    on e: Exception do
      result := e.message;
  END;
end;

function EvaluateToFloat(s0: string): extended;
begin
  TRY
    EvaluationError := '';
    cleanup(s0);
    result := evaluate(s0);
  EXCEPT
    on e: Exception do
    begin
      EvaluationError := e.message;
      result := 0;
    end;
  END;
end;

Function GetEvaluationError: string;
begin
  result := EvaluationError;
end;

end.
