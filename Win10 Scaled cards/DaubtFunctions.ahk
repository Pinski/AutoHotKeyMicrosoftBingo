; Spacing between cards
OffsetCardsHorizontal := 280
OffsetCardsVertical := 312

; The spacing beteen tiles
HorizontalSpacing := 52
VerticalSpacing := 42

MaxColumns()
{
	Global Cards

	; Game uses max columns depending on the amount of cards

	If (Cards < 5)
	{
		Return 2
	}
	Else If (Cards > 6)
	{
		Return 4
	}
	Else
	{
		Return 3
	}
}

DaubtRow(Row, FirstCardX, FirstCardY, OffsetCardX, OffsetCardY, SpaceX, SpaceY)
{
	Global Cards, Columns, Rows

	LastCardPreviousRow := (Columns * (Row - 1))
	CurrentCard = %LastCardPreviousRow%

	Loop, %Columns%
	{
		CurrentCard += 1

		If (CurrentCard > Cards) 
		{
			break
		}

		LeftCard := FirstCardX + ((A_Index - 1) * OffsetCardX)
		TopCard := FirstCardY + ((Row - 1) * OffsetCardY)

		DaubtCard(LeftCard, TopCard, SpaceX, SpaceY)
	}
}

DaubtCard(CardX, CardY, SpaceX, SpaceY) 
{
	X := CardX, Y := CardY

	MouseMove, %X%, %Y%, 0

	Loop, 5
	{
		DaubtColumn(X, Y, SpaceY, A_Index)

		If (A_Index < 5) 
		{
			X += SpaceX
			MouseMove, %X%, %Y%, 0
		}
	}
}

DaubtColumn(ColumnX, ColumnY, SpaceY, Column)
{
	Daubt(ColumnX, ColumnY)

	Loop, 4
	{
		ColumnY += SpaceY
		MouseMove, %ColumnX%, %ColumnY%, 0

		If (!(Column = 3 and A_Index = 2))
		{
			Daubt(ColumnX, ColumnY)
		}
	}
}

Daubt(TileX, TileY)
{
	Global UseColorCheck

	If (UseColorCheck = true) 
	{
		PixelGetColor, Color, %TileX%, %TileY%, RGB

		Red := SubStr(Color, 3, 2), Blue := SubStr(Color, 7, 2)

		If (!(Red == "CC" and Blue == "00") and !(Red == "FF" and Blue == "FF"))
		{
			MouseClick, Left, %TileX%, %TileY%, 2, 0
		}
	}
	Else
	{
		MouseClick, Left, %TileX%, %TileY%, 2, 0
	}
}