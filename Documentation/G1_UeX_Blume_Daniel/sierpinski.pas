PROGRAM sierpinski;

// Base
CONST HEIGHT = 2;
CONST LEN = 1;

// Area of a Triangle (<= 90)
FUNCTION AREA(height, side:REAL): REAL;
BEGIN
  AREA:=height*side/2;
END;

// Recursive (Area)
FUNCTION SIR_AREA(iter:INTEGER; H,L:REAL): REAL;
BEGIN
  IF iter <= 1 THEN
    SIR_AREA := AREA(H,L) // 1
  ELSE
    SIR_AREA := 3*SIR_AREA(iter-1, H/2, L/2);
END;

// Iterative (Area)
FUNCTION SIR_AREA_I(iter:INTEGER; H,L:REAL): REAL;
VAR A,RET:REAL;
BEGIN
  A:=AREA(H,L);
  RET:=1;
  WHILE(iter>1)DO
    BEGIN
      iter:=iter-1;
      RET:=RET*0.75;
    END;
  SIR_AREA_I := RET*A;
END;

// Recursive (Side Len)
FUNCTION SIR_LEN(iter:INTEGER; L:REAL): REAL;
BEGIN
  IF iter <= 1 THEN
    SIR_LEN := 3*L // 1
  ELSE
    SIR_LEN := 3*SIR_LEN(iter-1, L/2);
END;




BEGIN

  WriteLn('Sierpinski Area Recursive:  [5-(-1)]');

  WriteLn(SIR_AREA(5,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA(4,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA(3,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA(2,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA(1,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA(0,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA(-1,HEIGHT,LEN):3:5);

  WriteLn;
  WriteLn('Sierpinski Area Iterative: [5-(-1)]');

  WriteLn(SIR_AREA_I(5,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA_I(4,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA_I(3,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA_I(2,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA_I(1,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA_I(0,HEIGHT,LEN):3:5);
  WriteLn(SIR_AREA_I(-1,HEIGHT,LEN):3:5);

  WriteLn;
  WriteLn('Sierpinski Side Len: [5-(-1)]');

  WriteLn(SIR_LEN(5,LEN):3:5);
  WriteLn(SIR_LEN(4,LEN):3:5);
  WriteLn(SIR_LEN(3,LEN):3:5);
  WriteLn(SIR_LEN(2,LEN):3:5);
  WriteLn(SIR_LEN(1,LEN):3:5);
  WriteLn(SIR_LEN(0,LEN):3:5);
  WriteLn(SIR_LEN(-1,LEN):3:5);

END.
