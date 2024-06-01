#!/bin/bash

build_containers() {
    echo "Building Docker containers..."
    docker-compose build
}

run_containers() {
    echo "Starting Docker containers..."
    docker-compose up -d
}

stop_containers() {
    echo "Stopping Docker containers..."
    docker-compose down
}

case "$1" in
    build)
        build_containers
        ;;
    run)
        run_containers
        ;;
    stop)
        stop_containers
        ;;
    *)
        echo "Usage: $0 {build|run|stop}"
        exit 1
        ;;
esac

exit 0
