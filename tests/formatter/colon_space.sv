// No space between case item and colon, function/task/macro call
// and open parenthesis

function static f;
  case (x)
    default : break;
  endcase
  other ();
  `foo ();
endfunction
