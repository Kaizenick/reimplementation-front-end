import { capitalizeFirstWord } from "./dataFormatter";

describe("capitalizeFirstWord", () => {
  test("capitalizes the first character and lowercases the rest", () => {
    expect(capitalizeFirstWord("hELLO WORLD")).toBe("Hello world");
  });
});
