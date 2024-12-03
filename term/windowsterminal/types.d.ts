type Font = {
  face: string,
  cellHeight: string,
  size: number,
}

type Profile = {
  guid: string;
  name: string;
  source?: string;
  font?: Font;
  commandline: string;
  elevate: boolean;
  colorScheme: string;
  icon: string;
  startingDirectory: string;
  useAcrylic: boolean;
  hidden?: boolean;
};

type Colorscheme = {
  name: string;
  background: string;
  black: string;
  blue: string;
  brightBlack: string;
  brightBlue: string;
  brightCyan: string;
  brightGreen: string;
  brightPurple: string;
  brightRed: string;
  brightWhite: string;
  brightYellow: string;
  cursorColor: string;
  cyan: string;
  foreground: string;
  green: string;
  purple: string;
  red: string;
  selectionBackground: string;
  white: string;
  yellow: string;
};

export type { Colorscheme, Profile, Font };
