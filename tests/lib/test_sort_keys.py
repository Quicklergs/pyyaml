import yaml
import pprint
import sys

def test_sort_keys(input_filename, sorted_filename, verbose=False):
    with open(input_filename, 'rb') as fp:
        input = fp.read().decode('utf-8')
    with open(sorted_filename, 'rb') as fp:
        sorted = fp.read().decode('utf-8')
    data = yaml.load(input, Loader=yaml.FullLoader)
    dump_sorted = yaml.dump(data, default_flow_style=False, sort_keys=True)
    dump_unsorted = yaml.dump(data, default_flow_style=False, sort_keys=False)
    dump_unsorted = yaml.dump(data, default_flow_style=False, sort_keys=False, Dumper=yaml.SafeDumper)
    if verbose:
        print("INPUT:")
        print(input)
        print("DATA:")
        print(data)

    assert dump_sorted == sorted




test_sort_keys.unittest = ['.sort', '.sorted']

if __name__ == '__main__':
    import test_appliance
    test_appliance.run(globals())

