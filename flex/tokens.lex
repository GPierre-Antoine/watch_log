%{

%}

MODULE      module
IN          in
FILE        file
REGEX       regex
MESSAGE     message
STRING      [a-z][a-z_]+
COLON       :
SEMICOLON   ;
BRACKET_O   {
BRACKET_C   }
IGNORE      .

%%
{LINK}{QUOTE}   {in_tag=1;}
{QUOTE}         {if (in_tag==1){in_tag=0;printf("\n");}}
{WS}            ;
.              { if (in_tag){ printf(yytext);}}
%%
int main (int argc, char ** argv)
{
    argv+=1;
    argc-=1;
    if (argc>0)
    {
        yyin=fopen(argv[0], "r");
    }
    else
    {
        yyin=stdin;
    }
    yylex();
    return EXIT_SUCCESS;
}
