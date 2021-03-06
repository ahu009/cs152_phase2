#include "heading.h"

 int yyparse();

 int main(int argc, char **argv)
 {
   if (argc > 1) {
     if (freopen(argv[1], "r", stdin) == NULL) {
         cerr << argv[0] << ": File " << argv[1] << " can't be opened.\n";
             exit( 1 );
     }
   }

   yyparse();
   return 0;
 }
