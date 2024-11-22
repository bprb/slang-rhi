interface IModifier
{
    float modify(float val);
}

float test(
    float      value,
    IModifier  modifier)
{
    return modifier.modify(value);
}

RWStructuredBuffer<float> buffer;

struct Stuff
{
    IModifier modifier;
}

[numthreads(4, 1, 1)]
void computeMain(
    uniform Stuff stuff,
    int3    dispatchThreadID : SV_DispatchThreadID)
{
    let tid       = dispatchThreadID.x;
    let outputVal = test(buffer[tid], stuff.modifier);
    buffer[tid]   = outputVal;
}

struct MyModifier : IModifier
{
    float modify(float val)
    {
        return val * 2.0;
    }
}
