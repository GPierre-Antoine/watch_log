#include <iostream>
#include <csignal>
#include <functional>
#include <memory>
#include "src/signal_manager.h"


std_signal_manager *manager;


void siginthandler (int signal)
{
    std::cout << signal << std::endl;
    manager->stop();
}




int main(int argc, char **argv) {

    const std::string SOFT = [&]() {
        std::string holder = argv[0];
        holder = holder.substr(1 + holder.find_last_of('/'));
        return std::move(holder);
    }();

    if (argc < 2) {
        std::cerr << "Usage : " << SOFT << " filename" << std::endl;
        return EXIT_FAILURE;
    }

    manager = new std_signal_manager("/etc/watch_log.conf");
    signal(SIGINT, siginthandler);

    manager->start();


    return 0;
}
