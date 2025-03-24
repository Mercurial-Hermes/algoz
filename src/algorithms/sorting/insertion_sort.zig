const std = @import("std");

pub fn insertion_sort(comptime T: type, array: []T) void {
    for (array[1..], 1..) |v, j| {
        var i: i32 = @intCast(j - 1);
        while (i > -1 and array[@intCast(i)] > v) : (i -= 1) {
            array[@intCast(i + 1)] = array[@intCast(i)];
        }
        array[@intCast(i + 1)] = v;
    }
}

test "test insertion sort" {
    var a1 = [_]i32{ 5, 7, 6, 9, 8 };
    insertion_sort(i32, &a1);
    const e1 = [_]i32{ 5, 6, 7, 8, 9 };
    try std.testing.expectEqualSlices(i32, &e1, &a1);

    var a2 = [_]i32{ 5, 2, 4, 6, 1, 3 };
    insertion_sort(i32, &a2);
    const e2 = [_]i32{ 1, 2, 3, 4, 5, 6 };
    try std.testing.expectEqualSlices(i32, &e2, &a2);

    var a3 = [_]i32{ 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 };
    insertion_sort(i32, &a3);
    const e3 = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    try std.testing.expectEqualSlices(i32, &e3, &a3);

    var a4 = [_]i32{ 5, -5, 4, -4, 3, -3, 2, -2, 1, -1, 0 };
    insertion_sort(i32, &a4);
    const e4 = [_]i32{ -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5 };
    try std.testing.expectEqualSlices(i32, &e4, &a4);

    var a5 = [_]f32{ 5.1, -5.2, 4.0, -4, 3.2, -3, 2.7, -2.5, 1, -1.4, 0.7 };
    insertion_sort(f32, &a5);
    const e5 = [_]f32{ -5.2, -4, -3, -2.5, -1.4, 0.7, 1, 2.7, 3.2, 4.0, 5.1 };
    try std.testing.expectEqualSlices(f32, &e5, &a5);

    var a6 = [_]f32{ 500.1, -1000.5, 0 };
    insertion_sort(f32, &a6);
    const e6 = [_]f32{ -1000.5, 0, 500.1 };
    try std.testing.expectEqualSlices(f32, &e6, &a6);
}
