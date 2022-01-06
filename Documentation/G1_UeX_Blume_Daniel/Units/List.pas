UNIT List;

interface

  TYPE
    ListNodePtr = ^ListNode;
    ListNode = RECORD
      next: ListNodePtr;
      ch: CHAR;
    END; (* ListNode *)
    ListPtr = ListNodePtr;

  PROCEDURE InitList(VAR list: ListPtr);
  (* returns empty List *)
  PROCEDURE AddToList(VAR list:ListPtr; data:CHAR);
  (* appends Node with given data to List *)
  PROCEDURE PrintList(VAR list:ListPtr; delim:STRING);
  (* prints given List to stdout *)
  PROCEDURE DeinitList(VAR list: ListPtr);
  (* dispose all elements in List *)
  PROCEDURE Invert(VAR list: ListPtr);
  (* invert a given List *)

implementation


// Initalize a list
PROCEDURE InitList(VAR list:ListPtr);
BEGIN
  list := NIL;
END;

// Print out a given List
PROCEDURE PrintList(VAR list:ListPtr; delim:STRING);
VAR head : ListPtr;
BEGIN
  head := list;
  WHILE head <> NIL DO
    BEGIN
      Write(head^.ch);
      Write(delim);
      head := head^.next;
    END;
END;

// Add value to the end of given List
PROCEDURE AddToList(VAR list:ListPtr; data:CHAR);
VAR next, n : ListNodePtr;
BEGIN
  next := list;
  n := New(ListNodePtr);
  n^.next := NIL;
  n^.ch := data;
  IF next = NIL THEN
    list := n
  ELSE
  BEGIN
    WHILE next^.next <> NIL DO
      BEGIN
        next := next^.next;
      END;
    next^.next := n;
  END;
END;

// Dispose of List
PROCEDURE DeinitList(VAR list: ListPtr);
VAR
  head : ListPtr;
  temp : ListNodePtr;
BEGIN head := list;
  WHILE list <> NIL DO
    BEGIN
      temp := list^.next;
      Dispose(list);
      list := temp;
    END;
  list := head;
END;

// Prepend a Node to given List
PROCEDURE PrependNode(VAR list: ListPtr; newhead: ListNodePtr);
BEGIN
  IF newhead <> list THEN
  BEGIN
    IF newhead <> NIL THEN
      newhead^.next := list;
    list := newhead;
  END;
END;

// Invert given List
PROCEDURE Invert(VAR list: ListPtr);
VAR tmp, iter, head : ListPtr;
BEGIN
  head := list;
  iter := list;
  IF iter <> NIL THEN
    WHILE iter^.next <> NIL DO
      BEGIN
        tmp := iter^.next^.next;
        PrependNode(head, iter^.next);
        iter^.next := tmp;
      END;
  list := head;
END;

END.
