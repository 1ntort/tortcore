--!strict

export type Component = {
	_: {
		text: string,
		case: ("uc" | "sc")?,
		decorations: { [string]: Decoration },
		font: Font?,
		mark: Mark?,
		stroke: Stroke,
		children: { Component },
	},
	uppercase: (Component) -> Component,
	smallcaps: (Component) -> Component,
	decorate: (Component, ...Decoration) -> Component,
	font: (Component, Font) -> Component,
	mark: (Component, Mark) -> Component,
	stroke: (Component, Stroke) -> Component,
	append: (Component, Component) -> Component,
	appendSpace: (Component) -> Component,
	appendNewline: (Component) -> Component,
	build: (Component) -> string,
}
export type Decoration = {
	_: {
		decoration: string
	},
	tostring: (Decoration) -> string,
}
export type Font = {
	_: {
		color: string,
		size: number,
		face: string,
		family: string,
		weight: string,
		transparency: number,
	},
	color: (Font, Color3) -> Font,
	size: (Font, number) -> Font,
	face: (Font, string) -> Font,
	family: (Font, string) -> Font,
	weight: (Font, string) -> Font,
	transparency: (Font, number) -> Font,
	tostring: (Font) -> string,
}
export type Stroke = {
	_: {
		color: string,
		thickness: number,
		transparency: number,
		joins: string,
		sizing: string,
	},
	color: (Stroke, Color3) -> Stroke,
	thickness: (Stroke, number) -> Stroke,
	transparency: (Stroke, number) -> Stroke,
	joins: (Stroke, Joins) -> Stroke,
	sizing: (Stroke, Sizing) -> Stroke,
	tostring: (Stroke) -> string,
}
export type Mark = {
	_: {
		color: string,
		transparency: number,
	},
	color: (Mark, Color3) -> Mark,
	transparency: (Mark, number) -> Mark,
	tostring: (Mark) -> string,
}

export type Joins = "round" | "bevel" | "miter"
export type Sizing = "fixed" | "scaled"

return "TextType"
