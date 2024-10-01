# oku.core

This is a small snippet engine that allows you to insert some snippets into files.

## Usage

Download script, place on your path and call:

```bash
oku.core <N> <template> <snippet_name> <file>

oku.core 12 elixir read_file my_elixir_file.ex
```

```
N            - line number
template     - your predefined template
snippet_name - name of the snippet you want to insert
file         - name of the file you are inserting to
```

### Templates

You can create your own templates by creating a `JSON` file next to the `oku.core` file, and when calling, just provide template name as an argument, but without `.json` extension.

```json
{
    "read_file": "def read_file(file_name) #..."
}
```
