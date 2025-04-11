NAME := circuit-mecha-donald
VER := 1

.PHONY: all bom cpl garber

all: bom cpl garber

bom: $(NAME)-bom-raw.csv
	sed '/,""$$/d' $< >bom.csv

cpl: $(NAME)-all-pos.csv
	sed '/^"[ ABE-QSTV-Z]/d' $< >cpl.csv
	sed -i '/PCB_USB/d' cpl.csv
	patch -p1 <cpl-rename-col.patch

garber: out/$(NAME)-B_Cu.gbl out/$(NAME)-B_Mask.gbs out/$(NAME)-B_Paste.gbp out/$(NAME)-B_Silkscreen.gbo out/$(NAME)-Edge_Cuts.gm1 out/$(NAME)-F_Cu.gtl out/$(NAME)-F_Mask.gts out/$(NAME)-F_Paste.gtp out/$(NAME)-F_Silkscreen.gto out/$(NAME)-NPTH-drl_map.gbr out/$(NAME)-NPTH.drl out/$(NAME)-PTH-drl_map.gbr out/$(NAME)-PTH.drl
	zip $(NAME)-v$(VER).zip $^

# vim: noet
