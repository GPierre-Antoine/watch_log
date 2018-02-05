cmake_minimum_required(VERSION 3.5)
project(watch_log)

set(CMAKE_CXX_STANDARD 17)

add_executable(watch_log main.cpp src/signal_manager.h tokens.h)