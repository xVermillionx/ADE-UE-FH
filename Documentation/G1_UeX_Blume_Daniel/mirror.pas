PROGRAM MIRROR;

// None Recursive
// Function Mirror
FUNCTION MirrorNonRek(s: STRING): STRING;
VAR
  ret: STRING;
  i: INTEGER;
BEGIN
  ret := '';
  FOR i := 0 TO Length(s) DO
    BEGIN
      ret := ret + s[Length(s)-i];
    END;
  MirrorNonRek := ret;
END;


// Recursive
// Function Mirror
FUNCTION Mirror(s: STRING): STRING;
VAR
  ret: STRING;
  i: INTEGER;
BEGIN
  ret:='';
  // Shorten Lenfth of String to 1 (inefficient)
  FOR i := 1 TO Length(s)-1 DO
    ret := ret + s[i];
  // Check if End of String
  IF Length(s) < 1 THEN
    Mirror := s
  ELSE
    Mirror := s[Length(s)] + Mirror(ret);
END;

// Procedure Mirror
PROCEDURE Mirror2;
CONST e = '!';
VAR c: CHAR;
BEGIN
  Write('Read in Char: ');
  ReadLn(c);
  IF (c <> e) THEN
    Mirror2;
  Write(c);
END;

// Program
VAR strng: STRING;
BEGIN

Write('Input String: ');
ReadLn(strng);
WriteLn(Mirror(strng));

Mirror2; WriteLn;

END.

// Tests
WriteLn('Testing Mirror FUNCTION: ');
strng := 'This is a Test!';
Write(strng, ' | ');
WriteLn(Mirror(strng));
strng := '1,2,3,4,5,6,7';
Write(strng, ' | ');
WriteLn(Mirror(strng));
strng := 'Empty String: ""';
Write(strng, ' | ');
WriteLn(Mirror(''));
strng := '1';
Write(strng, ' | ');
WriteLn(Mirror(strng));
strng := '12';
Write(strng, ' | ');
WriteLn(Mirror(strng));
strng := 'Mirror(Mirror(this.toString()))';
Write(strng, ' | ');
WriteLn(Mirror(Mirror(strng)));

WriteLn;

WriteLn('Testing Mirror2 PROCEDURE: ');
Mirror2; WriteLn;
