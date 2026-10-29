# Stage 1: FrontEnd 
# Base Image
FROM node:24-alpine AS frontend

# Set destination for COPY
WORKDIR /demo/web

# Copy the dependency lists and patch config first, so the install step stays cached
COPY app/web/package.json app/web/pnpm-lock.yaml app/web/pnpm-workspace.yaml ./
COPY app/web/patches ./patches

# Enable pnpm (version from package.json) and install exact locked dependencies
RUN corepack enable && pnpm install --frozen-lockfile

# Copies the source code into workdir
COPY app/web .

# build the frontend
RUN pnpm release



# Stage 2: Backend
FROM golang:1.27.2-alpine AS builder

# Set destination for COPY
WORKDIR /demo

# Download Go modules
COPY app/go.mod app/go.sum ./
RUN go mod download

# Copies the source code. into the workdir directory
COPY app/ ./


# Copies the frontend built website into this workdir stage
COPY --from=frontend /demo/server/frontend/dist ./server/frontend/dist

# Compile one static Go binary with the frontend embedded and the version stamped in
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-X github.com/usememos/memos/internal/version.Version=26.10.1" -o /memos ./cmd/memos

# Create an empty data folder (scratch can't create folders)
RUN mkdir -p /data

# Stage 3: final image
FROM scratch AS runner

# CA certificates for HTTPS calls
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# The binary (frontend already embedded)
COPY --from=builder /memos /memos

# 3. A data folder the app can write to, owned by the non-root user
COPY --from=builder --chown=10001:10001 /data /data

# 4. Run as a non-root user
USER 10001

EXPOSE 8081

# Start Memos with its port and data folder
CMD ["/memos", "--data", "/data"]