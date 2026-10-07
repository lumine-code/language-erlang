const path = require("node:path");

describe("Erlang deprecated function attributes", () => {
  let editor;

  beforeEach(async () => {
    const pack = await lumine.packages.activatePackage(path.resolve(__dirname, ".."));
    editor = await lumine.workspace.open();
    editor.setGrammar(pack.grammars.find((grammar) => grammar.scopeName === "source.erlang"));
  });

  afterEach(() => editor.destroy());

  async function parse(text) {
    editor.setText(text);
    expect(await editor.whenGrammarSettled()).toBeTrue();
    return editor.getSyntaxNodeAtBufferPosition([0, 0], (node) => !node.parent);
  }

  it("accepts function/arity and mixed tuple forms without losing numeric scopes", async () => {
    const root = await parse("-deprecated(f/1).\n-deprecated([f/0, {g, 1}, h/2]).\n");
    expect(root.hasError).toBeFalse();
    expect(root.descendantsOfType("deprecated_fa").map((node) => node.text)).toEqual([
      "f/1",
      "f/0",
      "{g, 1}",
      "h/2",
    ]);
    expect(editor.scopeDescriptorForBufferPosition([0, 14]).getScopesArray()).toContain(
      "constant.numeric.erlang",
    );
  });

  it("keeps invalid slash arities and slash forms inside tuples invalid", async () => {
    expect((await parse("-deprecated(f/'_').\n")).hasError).toBeTrue();
    expect((await parse('-deprecated({f/1, "desc"}).\n')).hasError).toBeTrue();
  });

  it("updates the attribute parse after an unsaved edit", async () => {
    await parse("-deprecated({old, 1}).\n");
    const root = await parse("-deprecated(new/2).\n");
    expect(root.hasError).toBeFalse();
    const entry = root.descendantsOfType("deprecated_fa")[0];
    expect(entry.childForFieldName("fun").text).toBe("new");
    expect(entry.childForFieldName("arity").text).toBe("2");
  });
});
