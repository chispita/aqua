def GetDrop(ph, chlorine):
    if ((chlorine < 0.5) or (chlorine > 2) or (ph < 6.5) or (ph > 9.5)):
        return 'drop_brown'
    elif (chlorine >= 0.5 and chlorine <= 0.9) or (chlorine >= 1.1 and chlorine <= 2) and ph>=6.5 and ph <=9.5:
        return 'drop_green'
    else:
        return 'drop_blue'




print GetDrop(7, 0.9)
