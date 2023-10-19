# Define variables
IMAGE_NAME := rtpmidid-builder
CONTAINER_NAME := temp-container
HOST_OUTPUT_DIR := $(shell pwd)

# Default target to run when you type 'make'
all: build run copy cleanup

# Target to build the Docker image
build:
	@docker build -t $(IMAGE_NAME) .

# Target to run the Docker container
run:
	@docker rm -f $(CONTAINER_NAME) 2>/dev/null || true
	@docker create --name $(CONTAINER_NAME) $(IMAGE_NAME)

# Target to copy the .deb file from the container to the host
copy:
	@docker cp $(CONTAINER_NAME):/output/deb_files.tar $(HOST_OUTPUT_DIR)
	@tar -xvf $(HOST_OUTPUT_DIR)/deb_files.tar -C $(HOST_OUTPUT_DIR)
	@rm $(HOST_OUTPUT_DIR)/deb_files.tar

# Target to remove the temporary container
cleanup:
	@docker rm $(CONTAINER_NAME)

# Target to clean up any built images and containers (optional)
clean-all:
	@docker rmi $(IMAGE_NAME)
	@docker rm $(CONTAINER_NAME)
