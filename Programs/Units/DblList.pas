UNIT DblList;

interface

  TYPE
    DblListNodePtr = ^DblListNode;
    DblListEnds = RECORD
      head : DblListNodePtr;
      tail : DblListNodePtr;
    END;
    DblListNode = RECORD
      next: DblListNodePtr;
      prev: DblListNodePtr;
      ch: WORD;
    END; (* DblListNode *)
    DblListPtr = DblListNodePtr;

  PROCEDURE InitList(VAR list: DblListEnds);
  (* returns empty DblList *)
  PROCEDURE AddToList(VAR list:DblListEnds; data:WORD; rev:BOOLEAN);
  (* prepends/appends Node with given data to List *)
  PROCEDURE PrintList(VAR list:DblListEnds; delim:STRING);
  (* prints given DblList to stdout *)
  PROCEDURE DeinitList(VAR list: DblListEnds);
  (* dispose all elements in DblList *)
  PROCEDURE SplitAndMerge(VAR list: DblListEnds);
  (* split shuffles a given DblList *)

implementation

// Initalize a list
PROCEDURE InitList(VAR list:DblListEnds);
BEGIN
  list.head := NIL;
  list.tail := NIL;
END;

// Print out a given List
PROCEDURE PrintList(VAR list:DblListEnds; delim:STRING);
VAR head : DblListPtr;
BEGIN
  head := list.head;
  WHILE head <> NIL DO
    BEGIN
      Write(head^.ch);
      Write(delim);
      head := head^.next;
    END;
END;

// Add value to the begin/end of given List
PROCEDURE AddToList(VAR list:DblListEnds; data:WORD; rev:BOOLEAN);
VAR n : DblListNodePtr; 
BEGIN
  n := New(DblListNodePtr);
  n^.prev := NIL;
  n^.next := NIL;
  n^.ch := data;
  IF (list.head = NIL) AND (list.tail = NIL) THEN
    BEGIN
      list.head := n;
      list.tail := n;
    END
  ELSE IF rev THEN
    BEGIN
      n^.prev := list.tail;
      list.tail^.next := n;
      list.tail := n;
    END
  ELSE
    BEGIN
      n^.next := list.head;
      list.head^.prev := n;
      list.head := n;
    END;
END;

// Dispose of List
PROCEDURE DeinitList(VAR list: DblListEnds);
VAR
  temph: DblListNodePtr;
  tempt: DblListNodePtr;
BEGIN
  WHILE (list.head <> list.tail) AND (list.head <> list.tail^.prev) AND (list.head^.next <> list.tail) DO
    BEGIN
      temph := list.head^.next;
      tempt := list.tail^.prev;
      Dispose(list.tail);
      Dispose(list.head);
      list.head := temph;
      list.tail := tempt;
    END;
    IF (list.head <> list.tail) THEN
      BEGIN
        Dispose(list.head);
        Dispose(list.tail);
      END
    ELSE IF (list.head <> NIL) THEN
      BEGIN
        Dispose(list.head);
      END
    ELSE
    InitList(list);
END;

// Special Prepend Node Fucntion
PROCEDURE PrependNodeFromList(VAR insbef: DblListNodePtr; VAR node: DblListNodePtr);
VAR temp: DblListNodePtr;
BEGIN
  temp := insbef^.prev;
  insbef^.prev := node;

  IF node^.prev <> NIL THEN
    node^.prev^.next := node^.next;
  IF node^.next <> NIL THEN
    node^.next^.prev := node^.prev;

  node^.prev := temp;

  temp := insbef^.next;
  insbef^.next := node^.next;

  node^.next := insbef;

  insbef := temp;

END;

// Required SplitAndMerge Function
PROCEDURE SplitAndMerge(VAR list: DblListEnds);
VAR
  altlist, list2: DblListEnds;
  l1h, l2h, l1e, l2htemp: DblListPtr;
  isEven : BOOLEAN;

BEGIN
  altlist := list;
  
  // Check if List is too  small to shuffle
  IF list.head <> list.tail THEN
    BEGIN
      WHILE (altlist.head <> altlist.tail) AND (altlist.head <> altlist.tail^.prev) AND (altlist.head^.next <> altlist.tail) DO
        BEGIN
          altlist.head := altlist.head^.next;
          altlist.tail := altlist.tail^.prev;
        END;

      l1h := list.head;
      isEven := altlist.tail = altlist.head;
      IF isEven THEN
        l1e := altlist.head^.prev
      ELSE
        l1e := altlist.head;

      l2h := altlist.tail;
      altlist.head := l2h;
      altlist.tail := list.tail;

      WHILE (l2h <> NIL) AND (l1h <> l1e) DO
        BEGIN
          l2htemp := l2h^.next;

          PrependNodeFromList(l1h, l2h);

          l2h := l2htemp;
          list.head := list.head^.next;
        END;

      PrependNodeFromList(l1h, l2h);

      list := altlist;
    END;

END;

END.

(* PROCEDURE PrependNodeFromList(VAR list: DblListEnds; VAR node: DblListNodePtr; updateHead: BOOLEAN);
VAR temp: DblListNodePtr;
BEGIN
  temp := list.head^.prev;
  list.head^.prev := node;
  IF node^.next <> NIL THEN
    node^.next^.prev := list.head^.prev
  ELSE
    list.head^.next := node^.next;
  IF node^.prev <> NIL THEN // utterly usless in this case
    node^.prev^.next := list.head^.next;

  node^.prev := temp;
  node^.next := list.head;
  IF temp <> NIL then
    temp^.next := node;
  IF updateHead THEN
    list.head := node;
END; *)

(* PROCEDURE SplitDeck(VAR list: DblListEnds);
VAR
  altlist: DblListEnds;
  l1h, l2h, list2: DblListPtr;
BEGIN
  WHILE altlist.head <> altlist.tail^.prev DO
  BEGIN
    altlist.head := altlist.head^.next;
    altlist.tail := altlist.tail^.prev;
  END;
  // list.head TO altlist.head
  // altlist.tail TO list.tail
  list2 := list.head;
  l1h := list.head;
  l2h := altlist.tail;
  WHILE l2h^.next <> NIL DO
  BEGIN
  END;

END; *)
