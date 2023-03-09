# Stage 1 - Build Stage
FROM rust:1.66.1 as build

# Set the working directory to /app
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files
COPY Cargo.toml Cargo.lock ./

# Copy the source code into the container
COPY . .

# Install dependencies (for example, libraries required by diesel)
# You need to specify into exportedlibs the name of libs you want to keep into distroless image
# The libs will be stored to be transferred without worrying about the architecture of the machine that runs the script.
RUN apt-get update && apt-get install libpq5 -y && \
    mkdir -p temp_libs && \
    export LIBS="libpq.so* libgssapi_krb5.so* libldap_r-2.4.so* libkrb5.so* libk5crypto.so* libkrb5support.so* liblber-2.4.so* libsasl2.so* libgnutls.so* libp11-kit.so* libidn2.so* libunistring.so* libtasn1.so* libnettle.so* libhogweed.so* libgmp.so* libffi.so* libcom_err.so* libkeyutils.so*" && \
    for lib in $LIBS; do \
        find /usr/lib -name "$lib" -exec cp --parents {} ./temp_libs \;; \
    done && \
    mkdir -p exportedlibs && \
    mv temp_libs/usr/lib/* ./exportedlibs && \
    rm -r temp_libs

# ---------------------------------------------------
# 2 - Deploy Stage
#
# Use a distroless image for minimal container size
# - Copy `libpq` dependencies into the image (Required by diesel)
# - Copy application files into the image
# ---------------------------------------------------
FROM gcr.io/distroless/cc-debian11

# Copy required libs
COPY --from=build /app/exportedlibs/* /usr/lib/

