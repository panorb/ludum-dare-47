import sys
import itertools
from diff3 import merge
import re
from copy import copy

REF_REGEX = r"ExtResource\( [1-9]+ \)"

class ExtResource:
    def __init__(self, path, type_, idx):
        self.path = path
        self.type_ = type_
        self.idx = idx

    def __hash__(self):
        return hash(self.path) ^ hash(self.type_)
    
    def __eq__(self, other):
        return self.path == other.path and self.type_ == other.type_

    @staticmethod
    def from_definition(ref):
        ref = ref[1:-1]
        ref_parts = ref.split()
        ref_args = ref_parts[1:]
        
        args_key_values = []
        for ref_arg in ref_args:
            key, value = ref_arg.split("=")
            args_key_values.append(tuple([key, value]))
        # ref_key_values = [[tuple(key, value) for key, value in ref_arg.split("=")] for ref_arg in ref_args]
        args = dict(args_key_values)

        return ExtResource(args["path"], args["type"], int(args["id"]))
        # return ExtResource(path, type_)

    # def to_definition(self, idx):
    #    return f"[ext_resource path=\"{self.path}\" type=\"{self.type_}\" id={idx}]"
    
    def to_definition(self):
        return f"[ext_resource path=\"{self.path}\" type=\"{self.type_}\" id={self.idx}]"
    
    def to_ref(self):
        return f"ExtResource( {self.idx} )"

    def __repr__(self):
        return f"ExtResource(path={self.path}, type={self.type_})"

def idx_from_ref(ref):
    return int(ref.split(" ")[1])

if __name__ == "__main__":
    our_path = sys.argv[1] # our version of the file
    base_path = sys.argv[2] # base version of the file
    their_path = sys.argv[3] # their version of the file
    filename = sys.argv[4] # real file name

    with open(our_path) as f_our, open(base_path) as f_base, open(their_path) as f_their:
        our_version = f_our.read().splitlines()
        base_version = f_base.read().splitlines()
        their_version = f_their.read().splitlines()

    version_hierarchy = [base_version, our_version, their_version]
    edited_version_hierarchy = []

    # Using a dict here might seem like a strange decision, but it is actually used to mirror
    # the functionality of an OrderedSet which seems to be missing even from pythons
    # `collections` standard library
    # See https://stackoverflow.com/a/53657523
    resources = dict()

    for i, version in enumerate(iter(version_hierarchy)):
        version_name = "base"
        if (i == 1): version_name = "our"
        if (i == 2): version_name = "their"

        print(f"Now inspecting... {version_name} version")
        edited_version = copy(version)

        print(f"Listing definitions...")
        for line_definition in version:
            if line_definition.startswith("[ext_resource "):
                print(f"-- {line_definition}")

                resource = ExtResource.from_definition(line_definition)
                resources[resource] = None

                print(f"-- Listing references...")
                for j, line_all in enumerate(iter(version)):
                    matches = re.findall(REF_REGEX, line_all)
                    appended_edit = False

                    if matches:
                        match = matches[0]
                        idx = idx_from_ref(match)

                        if idx == resource.idx:
                            print(f"---- {line_all}")
                            edited_version[j] = line_all.replace(match, "{" + f"{str(hash(resource))}" + "}")

        # edited_version_hierarchy.append(edited_version)
        print("Final edit of " + version_name + " version:")
        print("\n".join(edited_version))
        print()

        if version_name == "our":
            with open("version_loop.tscn", 'w') as f:
                f.write("\n".join(edited_version))

        edited_version_hierarchy.append(edited_version)
    
    base_version, our_version, their_version = edited_version_hierarchy
    
    with open("outside_loop.tscn", 'w') as f:
        f.write("\n".join(our_version))

    # To provide access to the index(obj) method to make looking up the index a lot more pythonic
    resources = list(resources)
    print("Listing all resources...")
    print(resources)


    merge_result = merge(our_version, base_version, their_version)
    merge_body = merge_result["body"]

    print("Merged version of our edits...")

    with open("merged_version.tscn", 'w') as f:
        f.write("\n".join(merge_body))
    sys.exit(0)

    pre_body = []
    for line_version in merge_body:
        if (line_version.startswith("[ext_resource ")):
            resource = ExtResource.from_definition(line_version)
            resource.idx = resources.index(resource)
            pre_body.append(resource.to_definition())
        else:
            pre_body.append(line_version)

    final_body = []
    for line in pre_body:
        for resource in resources:
            resource.idx = resources.index(resource)
            line = line.replace("{" + f"{str(hash(resource))}" + "}", resource.to_ref())
            final_body.append(line)

    # print("Showing result...")
    # print("\n".join(final_body))