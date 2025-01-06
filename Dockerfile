# Use a Rust base image
FROM rust:slim-bullseye 

# Install ling build tools
RUN apt update && apt install -y cmake clang build-essential llvm git

# Install rust tools
RUN rustup default 1.81.0
RUN rustup target add wasm32-unknown-unknown
RUN rustup component add rustfmt
RUN rustup component add clippy

# Install audit tools
RUN cargo install cargo-audit

# Install Scrypto
RUN cargo install --force radix-clis@1.3.0

# Check if scrypto is installed
RUN scrypto --version

# Set working directory as /src
WORKDIR /src