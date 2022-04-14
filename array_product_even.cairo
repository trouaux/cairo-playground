%builtins output

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word

func array_product(arr : felt*, size) -> (sum):
    if size == 0:
        return (sum=1)
    end

    # size is not zero.
    let (sum_of_rest) = array_product(arr=arr + 2, size=size - 2)
    return (sum=[arr] * sum_of_rest)
end

func main{output_ptr : felt*}():
    const ARRAY_SIZE = 4

    # Allocate an array.
    let (ptr) = alloc()

    # Populate some values in the array.
    assert [ptr] = 2
    assert [ptr + 1] = 3
    assert [ptr + 2] = 4
    assert [ptr + 3] = 5

    # Call array_product to compute the sum of the elements.
    let (sum) = array_product(arr=ptr, size=ARRAY_SIZE)

    # Write the sum to the program output.
    serialize_word(sum)

    return ()
end
