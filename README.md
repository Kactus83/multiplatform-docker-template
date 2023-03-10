This project is a Dockerfile template that allows for creating lightweight images using a multi-stage build. It is adapted to multiple architectures. 

The Dockerfile consists of two stages: 

1. Build Stage: This stage uses rust:1.66.1 as its base image and copies the Cargo.toml and Cargo.lock files into the container, followed by copying the source code into the container and installing dependencies (e.g., libraries required by diesel). The necessary libraries are stored in order to be transferred without worrying about the architecture of the machine that runs the script. 

2. Deploy Stage: This stage uses gcr.io/distroless/cc-debian11 as its base image, copies required libs from build stage, followed by copying application files into the image. Required libs are added to distroless image without anything else superfluous


---------------------------------------------------------
                      How to use ?
---------------------------------------------------------

1- Remplace empty template with your projet

2- Edit Dockerfile : change libs installation method in order to install the libs you need

3- Edit Dockerfile : change libs names with the name of the libs you want to keep in your distroless image.

NOTE: For now, libs that could be automaticaly copied to distroless image should be installed in usr/lib in the builder image. I'll think better detection system later. 
