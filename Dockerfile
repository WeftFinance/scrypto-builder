# Use a Rust base image
FROM rust:slim-bullseye 

# Install ling build tools
RUN apt update && apt install -y cmake clang build-essential llvm git

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Install rust tools
RUN rustup update stable
RUN rustup target add wasm32-unknown-unknown
RUN rustup component add rustfmt
RUN rustup component add clippy
RUN cargo install cargo-audit
RUN git clone https://github.com/radixdlt/radixdlt-scrypto.git
# RUN cd radixdlt-scrypto && git checkout tags/v1.0.1
RUN cargo install --path ./radixdlt-scrypto/simulator

# Set working directory as /src
WORKDIR /src

ENTRYPOINT ["scrypto", "test", "--path", "/src"]
