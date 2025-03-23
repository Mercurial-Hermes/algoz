const std = @import("std");

pub fn insertion_sort(array: []i32) void {
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
    insertion_sort(&a1);
    const e1 = [_]i32{ 5, 6, 7, 8, 9 };
    try std.testing.expectEqualSlices(i32, &e1, &a1);

    var a2 = [_]i32{ 5, 2, 4, 6, 1, 3 };
    insertion_sort(&a2);
    const e2 = [_]i32{ 1, 2, 3, 4, 5, 6 };
    try std.testing.expectEqualSlices(i32, &e2, &a2);

    var a3 = [_]i32{ 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 };
    insertion_sort(&a3);
    const e3 = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    try std.testing.expectEqualSlices(i32, &e3, &a3);

    var a4 = [_]i32{ 5, -5, 4, -4, 3, -3, 2, -2, 1, -1, 0 };
    insertion_sort(&a4);
    const e4 = [_]i32{ -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5 };
    try std.testing.expectEqualSlices(i32, &e4, &a4);
}
