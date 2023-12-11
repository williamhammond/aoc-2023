const std = @import("std");

pub fn main() !void {
    const cwd = std.fs.cwd();
    const file = try cwd.openFile("src/data.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var buf: [1024]u8 = undefined;

    var result: u64 = 0;
    while (try buf_reader.reader().readUntilDelimiterOrEof(&buf, '\n')) |line| {
        result += process_line(line);
    }
    std.debug.print("{d}\n", .{result});
}

fn process_line(line: []const u8) u8 {
    var firstDigit: ?u8 = null;
    var secondDigit: u8 = 0;
    for (line) |char| {
        if (std.ascii.isDigit(char)) {
            if (firstDigit == null) {
                firstDigit = char - 48;
            }
            secondDigit = char - 48;
        }
    }

    return (firstDigit.? * 10) + secondDigit;
}
