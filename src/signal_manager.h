//
// Created by pierreantoine on 05/02/18.
//

#ifndef WATCH_LOG_SIGNAL_MANAGER_H
#define WATCH_LOG_SIGNAL_MANAGER_H

#include <iostream>
#include <stdexcept>
#include <sys/inotify.h>
#include <unistd.h>
#include <vector>

template <size_t event_count,size_t buffer_size>
class signal_manager {
private:
    enum app_state {
        stopped, started
    };
    app_state state;
    char buffer[event_count*buffer_size]{};
    int inotify_fd;
    void loop();
    void run();

public:
    void stop();
    void start();
    void reload();
    void add_file(const std::string & filename);

    signal_manager(const std::string & configuration_file);

    ~signal_manager();

    std::vector<int> watched_files;
    const char *configuration_file;
};

template <size_t event_count,size_t buffer_size>
signal_manager<event_count,buffer_size>::signal_manager(const std::string & configuration_file) :
        inotify_fd (inotify_init()),
    configuration_file (configuration_file.c_str()),
    state (stopped)
{
    if (inotify_fd < 0) {
        throw std::runtime_error("inotify_init");
    }
}

template<size_t event_count,size_t buffer_size>
void signal_manager<event_count,buffer_size>::start() {
    if (state == started)
    {
        throw std::runtime_error("already_in_use");
    }

    loop();
}

template<size_t event_count,size_t buffer_size>
void signal_manager<event_count,buffer_size>::loop() {
    for (this->state = started;state == started;) {
        run();
    }
}

template<size_t event_count,size_t buffer_size>
void signal_manager<event_count,buffer_size>::reload() {

}

template<size_t event_count,size_t buffer_size>
signal_manager<event_count,buffer_size>::~signal_manager() {
    this->stop();
    close(inotify_fd);
}

template<size_t event_count,size_t buffer_size>
void signal_manager<event_count,buffer_size>::stop() {
    this->state = stopped;
    for (auto file_desc:watched_files)
    {
        inotify_rm_watch(file_desc,inotify_fd);
    }
    watched_files.clear();
}

template<size_t event_count,size_t buffer_size>
void signal_manager<event_count,buffer_size>::add_file(const std::string &filename)
{
    watched_files.push_back(inotify_add_watch( inotify_fd, filename.c_str(),IN_MODIFY));
}

template<size_t event_count, size_t buffer_size>
void signal_manager<event_count, buffer_size>::run() {

}

using std_signal_manager = signal_manager<16,sizeof (struct inotify_event)>;

#endif //WATCH_LOG_SIGNAL_MANAGER_H
