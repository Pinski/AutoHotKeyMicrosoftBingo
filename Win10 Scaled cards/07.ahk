; Tested on Windows 10, 100% Scale
; Game Cards at size 50

#include %A_LineFile%\..\DaubtFunctions.ahk

; Check the color of the tile before clicking it twice, this is slower on empty boards, but will gain speed later on
UseColorCheck := false

; Number of card in play
Cards := 7

; The center of the first tile on the first card
CenterFirstColumn := 505
CenterFirstRow := 380

; Spacing between cards
OffsetCardsHorizontal := 280
OffsetCardsVertical := 312

; The spacing beteen tiles
HorizontalSpacing := 52
VerticalSpacing := 42

^p::Pause ; Ctrl+P Pause
^b::      ; Ctrl+B AutoDaubt
{
	; Get resolution of current application
	WinGetPos, X, Y, Width, Height, A

	; Exclude left and right from width
	AvailableWidth := Width - 400 - 260
	; Exclude top and bottom from height
	AvailableHeight := Height - 76 - 10

	; Grid layout of the board
	Columns := Floor(AvailableWidth / OffsetCardsHorizontal) <= MaxColumns() ? Floor(AvailableWidth / OffsetCardsHorizontal) : MaxColumns()
	Rows := Ceil(Cards / Columns)
MsgBox, %CenterFirstColumn%, %Columns%
	CenterFirstColumn := 400 + Floor((AvailableWidth - (Columns * OffsetCardsHorizontal)) / 2) + 36
MsgBox, %CenterFirstColumn%
	Loop, %Rows%
	{
		DaubtRow(A_Index, CenterFirstColumn, CenterFirstRow, OffsetCardsHorizontal, OffsetCardsVertical, HorizontalSpacing, VerticalSpacing)
	}

	Return
}