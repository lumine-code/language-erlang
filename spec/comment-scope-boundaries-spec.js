const path = require("path");

// A line-comment scope is also a promise that appending ordinary text at its
// end stays inside the comment. Closed blocks and comment-styled syntax must
// not make that promise to the editor's retained highlighting.
describe("language-erlang comment scope boundaries", () => {
  let editor;

  beforeEach(async () => {
    jasmine.useRealClock();
    await lumine.packages.activatePackage(path.resolve(__dirname, ".."));
    editor = await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName("source.erlang"));
  });

  afterEach(() => editor?.destroy());

  const samples = [
    ["f(_note) -> ok.", "_note", "comment.other.discard.erlang"],
    ["% note", "note", "comment.line.erlang"],
  ];
  for (const [text, token, expected, grammarScope] of samples) {
    it("classifies " + JSON.stringify(text) + " as " + expected, async () => {
      if (grammarScope) editor.setGrammar(lumine.grammars.grammarForScopeName(grammarScope));
      editor.setText(text);
      await editor.languageMode.ready;
      await editor.languageMode.atGrammarSettlement();
      await editor.languageMode.refresh?.();
      const position = editor.getBuffer().positionForCharacterIndex(text.indexOf(token));
      const scopes = editor.scopeDescriptorForBufferPosition(position).getScopesArray();
      expect(scopes).toContain(expected);
      if (!expected.startsWith("comment.line.")) {
        expect(scopes.some((scope) => scope.startsWith("comment.line."))).toBe(false);
      } else {
        expect(scopes.some((scope) => scope.startsWith("comment.block."))).toBe(false);
      }
    });
  }
});
