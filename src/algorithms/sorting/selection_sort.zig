const std = @import("std");

pub fn selection_sort(comptime T: type, array: []T) ![]T {
    const l = array.len;
    var ct: usize = 0;
    var visited = try std.heap.page_allocator.alloc(bool, l);
    var trg = try std.heap.page_allocator.alloc(T, l);
    defer std.heap.page_allocator.free(visited);
    @memset(visited, false);
    
    while (ct < l) {
        var lowest: T = -1;
        var lowest_idx: usize = 0;
        
        for (array[0..], 0..) |v, i| {
            if (visited[i] == false) {
                if (lowest == -1 or v < lowest) {
                    lowest = v;
                    lowest_idx = i;
                }
            }
        }
        visited[lowest_idx] = true;
        trg[ct] = lowest;
        ct += 1;
    }
    
    return trg;
}

test "selection sort" {
    var a1 = [_]i32{ 64, 34, 25, 12, 22, 11, 90 };
    const sorted = try selection_sort(i32, &a1);
    defer std.heap.page_allocator.free(sorted);
    const e1 = [_]i32{ 11, 12, 22, 25, 34, 64, 90 };
    try std.testing.expectEqualSlices(i32, &e1, sorted);

    var a2 = [_]i32{ 64, 34, 25, 12, 22, 11, 90, 64, 11 };
    const sorted2 = try selection_sort(i32, &a2);
    defer std.heap.page_allocator.free(sorted2);
    const e2 = [_]i32{ 11, 11, 12, 22, 25, 34, 64, 64, 90 };
    try std.testing.expectEqualSlices(i32, &e2, sorted2);

    var a3 = [_]i32{ 1 };
    const sorted3 = try selection_sort(i32, &a3);
    defer std.heap.page_allocator.free(sorted3);
    const e3 = [_]i32{ 1 };
    try std.testing.expectEqualSlices(i32, &e3, sorted3);

    var a4 = [_]f32{ 1.1, 2.2, 3.3, 4 };
    const sorted4 = try selection_sort(f32, &a4);
    defer std.heap.page_allocator.free(sorted4);
    const e4 = [_]f32{ 1.1, 2.2, 3.3, 4 };
    try std.testing.expectEqualSlices(f32, &e4, sorted4);

    var a5 = [_]f32{ 1.1, 2.2, 3.3, 4, -5, -7.4, 8 };
    const sorted5 = try selection_sort(f32, &a5);
    defer std.heap.page_allocator.free(sorted5);
    const e5 = [_]f32{ -7.4, -5, 1.1, 2.2, 3.3, 4, 8 };
    try std.testing.expectEqualSlices(f32, &e5, sorted5);
}