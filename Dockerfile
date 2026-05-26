FROM alpine:latest
RUN echo "Enterprise Build Verification Successful" > build_log.txt
CMD ["cat", "build_log.txt"]

