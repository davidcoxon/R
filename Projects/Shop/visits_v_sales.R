png("visits_v_sales.png",type="quartz")

with(visitsales,plot(gross,shop_visits, col=c("orange","yellow","green","blue","purple","red","pink")))

legend("topright", legend=c("wednesday","thursday","friday","saturday","sunday","monday","tuesday"),col=c("orange","yellow","green","blue","purple","red","pink"), lwd=3, bty="n")

dev.off()