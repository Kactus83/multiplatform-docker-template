# Stage 1 - Build Stage
FROM rust:1.66.1 as build

# Set the working directory to /app
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files
COPY Cargo.toml Cargo.lock ./

# Copy the source code into the container
COPY . .

# Install dependencies (Required by diesel)
RUN apt-get update && apt-get install libpq5 -y && \
    mkdir -p temp_libs && \
    libs=("libpq.so*" "libgssapi_krb5.so*" "libldap_r-2.4.so*" "libkrb5.so*" "libk5crypto.so*" "libkrb5support.so*" "liblber-2.4.so*" "libsasl2.so*" "libgnutls.so*" "libp11-kit.so*" "libidn2.so*" "libunistring.so*" "libtasn1.so*" "libnettle.so*" "libhogweed.so*" "libgmp.so*" "libffi.so*" "libcom_err.so*" "libkeyutils.so*") && \
    for lib in "${libs[@]}"; do \
        find /usr/lib -name "$lib" -exec cp --parents {} ./temp_libs \;; \
    done && \
    mv temp_libs/* /usr/local/cargo/lib/ && \
    rm -r temp_libs



