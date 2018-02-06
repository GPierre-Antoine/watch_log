%{
#include <iostream>
#include "/home/pierreantoine/workspace/watch_log/tokens.h"
using namespace std;

%}

IN          in
TYPE        file|regex|module|message|handler
IDENTIFIER  [a-z][a-z_]+
COLON       :
SEMICOLON   ;
BRACKET_O   \{
BRACKET_C   \}
BRACE_O   [
BRACE_C   ]
DOUBLE_QUOTE       "
SIMPLE_QUOTE       '
STRING_D      DOUBLE_QUOTE[^{DOUBLE_QUOTE}]+DOUBLE_QUOTE
STRING_S      SIMPLE_QUOTE[^{SIMPLE_QUOTE}]+SIMPLE_QUOTE
COMMA       ,

%%
{IN}              return lexed_types::in;
{SEMICOLON}       return lexed_types::semicolon;
{BRACKET_O}       return lexed_types::bracket_open;
{BRACKET_C}       return lexed_types::bracket_close;
{BRACE_O}         return lexed_types::brace_open;
{BRACE_C}         return lexed_types::brace_close;
{COLON}           return lexed_types::colon;
{TYPE}            return lexed_types::type;
{STRING_D}        return lexed_types::string;
{STRING_S}        return lexed_types::string;
{IDENTIFIER}      return lexed_types::identifier;
{COMMA}           return lexed_types::comma;
.        ;
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
