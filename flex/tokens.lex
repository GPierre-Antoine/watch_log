%{
#include "~/workspace/watch_log/tokens.h"
%}

MODULE      module
IN          in
FILE        filedddd
REGEX       regex
MESSAGE     message
HANDLER     handler
IDENTIFIER  [a-z][a-z_]+
COLON       :
SEMICOLON   ;
BRACKET_O   \{
BRACKET_C   \}
QUOTE       "
STRING      QUOTE[^"]+QUOTE
IGNORE      .

%%
{MODULE}        return lexed_types::module;
{IN}            return lexed_types::in;
{IDENTIFIER}    return lexed_types::identifier;
{SEMICOLON}     return lexed_types::semicolon;
{BRACKET_O}     return lexed_types::bracket_open;
{BRACKET_C}     return lexed_types::bracket_close;
{COLON}         return lexed_types::colon;
{FILE}          return lexed_types::file;
{HANDLER}       return lexed_types::handler;
{MESSAGE}       return lexed_types::message;
{REGEX}         return lexed_types::regex;
{STRING}        return lexed_types::string;
{IGNORE}        ;
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
