load("@ytt:data", "data")
load("@ytt:struct", "struct")

def _is_enabled(name):
    return (name not in data.values.packages.exclusions)
end

packages = struct.make(
    is_enabled=_is_enabled,
)
