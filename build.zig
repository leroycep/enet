const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const enet = b.addStaticLibrary(.{
        .name = "enet",
        .target = target,
        .optimize = optimize,
    });
    enet.addCSourceFiles(.{ .files = &.{
        "callbacks.c",
        "compress.c",
        "host.c",
        "list.c",
        "packet.c",
        "peer.c",
        "protocol.c",
        "unix.c",
        "win32.c",
    } });
    enet.addIncludePath(.{ .path = "include" });
    enet.installHeadersDirectoryOptions(.{
        .source_dir = .{ .path = "include/enet" },
        .install_dir = .header,
        .install_subdir = "enet",
    });
    enet.linkLibC();
    b.installArtifact(enet);
}
