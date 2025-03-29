//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.
const std = @import("std");
const insertion_sort = @import("algorithms/sorting/insertion_sort.zig");

pub fn main() !void {
    // Example array to sort
    var numbers = [_]i32{ 64, 34, 25, 12, 22, 11, 90, -4};
    
    std.debug.print("Original array: ", .{});
    for (numbers) |n| {
        std.debug.print("{d} ", .{n});
    }
    std.debug.print("\n", .{});

    // Sort the array
    insertion_sort.insertion_sort(i32, &numbers);

    std.debug.print("Sorted array: ", .{});
    for (numbers) |n| {
        std.debug.print("{d} ", .{n});
    }
    std.debug.print("\n", .{});
}
