PROGRAM binary;
uses Crt;

CONST max = 10;

TYPE
  IntArray = ARRAY [1..max] OF INTEGER;

FUNCTION Contains(a: IntArray; left, right: INTEGER; x:INTEGER): BOOLEAN;
VAR middle: INTEGER;
BEGIN
  // Debug Print Statement
  WriteLn(a[left], ' - ', a[right], '  ', 'x: ', x);
  IF (a[left] = x) OR (a[right] = x) THEN
    Contains := TRUE
  // ELSE IF left = right THEN
  ELSE IF a[left] = a[right] THEN
    Contains := FALSE
  ELSE
    BEGIN
      middle := (left + right) DIV 2;
      IF x <= a[middle] THEN
        BEGIN
          left:=left;
          right:=middle;
        END
      ELSE
        BEGIN
          left:=middle+1;
          right:=right;
        END;
      Contains := Contains(a, left, right, x);
    END;
END;

VAR
  C : IntArray;
  i : INTEGER;

BEGIN

// Fill Array: with 1st max even numbers
FOR i:=LOW(C) TO HIGH(C) DO
  BEGIN
    C[i] := i*2;
  END;

// Check if All Elements are contained in Array
WriteLn('Check All Elements Contained');
  FOR i:=LOW(C) TO HIGH(C) DO
    BEGIN
      Write(Contains(C, LOW(c), HIGH(C), C[i]));
      WriteLn(' = TRUE Expected');
      WriteLn;
    END;

// Output
WriteLn('Test Outputs adjust x');
  Write(Contains(C, 1, max, 1));  WriteLn(' = FALSE Expected'); WriteLn;
  Write(Contains(C, 1, max, 2));  WriteLn(' = TRUE Expected');  WriteLn;
  Write(Contains(C, 1, max, 4));  WriteLn(' = TRUE Expected');  WriteLn;
  Write(Contains(C, 1, max, 7));  WriteLn(' = FALSE Expected'); WriteLn;
  Write(Contains(C, 1, max, 9));  WriteLn(' = FALSE Expected'); WriteLn;
  Write(Contains(C, 1, max, 12)); WriteLn(' = TRUE Expected');  WriteLn;
  Write(Contains(C, 1, max, 13)); WriteLn(' = FALSE Expected'); WriteLn;
  Write(Contains(C, 1, max, 14)); WriteLn(' = TRUE Expected');  WriteLn;

// Adjust left, right parameter
WriteLn('Test Outputs adjust x, left, right');
  Write(Contains(C, 1, max, 2));   WriteLn(' = TRUE Expected');  WriteLn;
  Write(Contains(C, 4, max, 4));   WriteLn(' = FALSE Expected'); WriteLn;
  Write(Contains(C, 10, max, 14)); WriteLn(' = FALSE Expected'); WriteLn;
  Write(Contains(C, 10, max, 20)); WriteLn(' = TRUE Expected');  WriteLn;
  Write(Contains(C, 11, max, 20)); WriteLn(' = TRUE Expected');  WriteLn;
  Write(Contains(C, 11, 11, 20));  WriteLn(' = FALSE Expected'); WriteLn;
  Write(Contains(C, 1, 1, 20));    WriteLn(' = FALSE Expected'); WriteLn;

END.
