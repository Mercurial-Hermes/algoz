//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.
const std = @import("std");
const insertion_sort = @import("algorithms/sorting/insertion_sort.zig");

fn generateRandomArray(comptime T: type, size: usize) ![]T {
    const array = try std.heap.page_allocator.alloc(T, size);
    for (array) |*item| {
        var random_value: i32 = undefined;
        std.crypto.random.bytes(std.mem.asBytes(&random_value));
        item.* = @intCast(@mod(random_value, 2001) - 1000); // Range: -1000 to 1000
    }
    return array;
}

fn printArray(comptime T: type, array: []const T) void {
    std.debug.print("[", .{});
    for (array, 0..) |item, i| {
        if (i > 0) std.debug.print(", ", .{});
        std.debug.print("{d}", .{item});
    }
    std.debug.print("]\n", .{});
}

pub fn main() !void {
    const sizes = [_]usize{ 1000, 50000, 100000, 150000, 200000 };
    
    for (sizes) |size| {
        std.debug.print("\nTesting array size: {d}\n", .{size});
        
        // Generate random array
        const array = try generateRandomArray(i32, size);
        defer std.heap.page_allocator.free(array);
        
        // std.debug.print("Original array: ", .{});
        // printArray(i32, array);
        
        // Measure sorting time
        const start = std.time.milliTimestamp();
        insertion_sort.insertion_sort(i32, array);
        const end = std.time.milliTimestamp();
        const duration = @as(f64, @floatFromInt(end - start));
        
        const n_squared = @as(f64, @floatFromInt(size * size));
        std.debug.print("Time taken: {d:.2} ms\n", .{duration});
        std.debug.print("n²: {d:.2}\n", .{n_squared});
        std.debug.print("Time/n²: {d:.6} ms\n", .{duration / n_squared});
        
        // std.debug.print("Sorted array: ", .{});
        // printArray(i32, array);
    }
}
