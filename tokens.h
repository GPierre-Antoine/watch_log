//
// Created by pierreantoine on 05/02/18.
//

#ifndef WATCH_LOG_TOKENS_H
#define WATCH_LOG_TOKENS_H

enum class lexed_types {
    module,
    in,

    identifier,

    semicolon,
    bracket_open,
    bracket_close,
    colon,

    file,
    handler,
    message,
    regex,

    string

};

#endif //WATCH_LOG_TOKENS_H