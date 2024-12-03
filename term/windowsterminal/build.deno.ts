import type { Colorscheme, Profile, Font } from "./types.d.ts";
//const windowsTermProfileDefault = {
//  elevate: false,
//  startingDirectory: "%USERPROFILE%",
//  useAcrylic: false,
//  hidden: false,
//};

const read = Deno.readTextFile;

const srcDirPath = "./src";
const csDirPath = `${srcDirPath}/colorschemes`;
const defaultColorSchemePath = `${csDirPath}/default.json`;
const myColorschemePath = `${csDirPath}/mycolor.onehalfdark.json`;

const profileDirPath = `${srcDirPath}/profiles`;
const profilePath = `${profileDirPath}/default.json`;
const listDirPath = `${profileDirPath}/list`;

const base = JSON.parse(await read(srcDirPath + "/base.json"));
const actions = JSON.parse(await read(srcDirPath + "/actions.json"));
const font = JSON.parse(await read(srcDirPath + "/font.json")) as Font;

// colorschemes
const colorschemeList = JSON.parse(await read(defaultColorSchemePath)) as Colorscheme[];
colorschemeList.push(JSON.parse(await read(myColorschemePath) as Colorscheme));

// profiles
const profileList: Profile[] = [];
const defaultProfile = JSON.parse(
  await read(profilePath),
) as Profile;
const profileFileNameListAsync = Deno.readDir(listDirPath);
for await (const file of profileFileNameListAsync) {
  const p = JSON.parse(
    await read(`${listDirPath}/${file.name}`),
  ) as Profile;
  p.font = font;
  profileList.push(p);
}
const profiles = {
  defaults: defaultProfile,
  list: profileList,
};

// combine
base.actions = actions;
base.font = font;
base.profiles = profiles;
base.schemes = colorschemeList;

// write
const json = JSON.stringify(base, null, 4);
Deno.writeTextFile("./dist/settings.json", json);

export {};
