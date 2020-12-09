from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from .models import * #VSCode hates this, I don't know why, it just does
from django.db import connection
from .forms import *

# Create your views here.
def index(request):
    print("Rendered index")
    all_members = User.objects.raw('''
        SELECT *
        FROM user
    ''')
    return render(request, "DDChar/index.html", {'all':all_members}) #Pass all to html via dictionary

def spells(request):
    print("Rendered spells")
    if request.method == "POST":
        if 'createbtn' in request.POST:
            print("POST Success")
            form = spellForm(request.POST or None)
            theclasses = request.POST["classnames"]
            thelist = []
            for classid in theclasses.split(' '):
                print(classid)
                if classid.lower() == "bard":
                    thelist.append(1)
                if classid.lower() == "cleric":
                    thelist.append(2)
                if classid.lower() == "druid":
                    thelist.append(3)
                if classid.lower() == "paladin":
                    thelist.append(6)
                if classid.lower() == "ranger":
                    thelist.append(7)
                if classid.lower() == "sorcerer":
                    thelist.append(9)
                if classid.lower() == "warlock":
                    thelist.append(10)
                if classid.lower() == "wizard":
                    thelist.append(11)
            if form.is_valid():
                for x in range(len(thelist)):
                    print(thelist[x])
                    if thelist[x] == 1:
                        caster = Classspell(clsp_ability="CHR", clsp_id=thelist[x], clsp_name=request.POST["sp_name"])
                        caster.save()
                    if thelist[x] == 2:
                        caster = Classspell(clsp_ability="WIS", clsp_id=thelist[x], clsp_name=request.POST["sp_name"])
                        caster.save()
                    if thelist[x] == 3:
                        caster = Classspell(clsp_ability="WIS", clsp_id=thelist[x], clsp_name=request.POST["sp_name"])
                        caster.save()
                    if thelist[x] == 6:
                        caster = Classspell(clsp_ability="CHR", clsp_id=thelist[x], clsp_name=request.POST["sp_name"])
                        caster.save()
                    if thelist[x] == 7:
                        caster = Classspell(clsp_ability="WIS", clsp_id=thelist[x], clsp_name=request.POST["sp_name"])
                        caster.save()
                    if thelist[x] == 9:
                        caster = Classspell(clsp_ability="CHR", clsp_id=thelist[x], clsp_name=request.POST["sp_name"])
                        caster.save()
                    if thelist[x] == 10:
                        caster = Classspell(clsp_ability="CHR", clsp_id=thelist[x], clsp_name=request.POST["sp_name"])
                        caster.save()
                    if thelist[x] == 11:
                        caster = Classspell(clsp_ability="INT", clsp_id=thelist[x], clsp_name=request.POST["sp_name"])
                        caster.save()
                print("SAVE")
                form.save()
        if 'deletebtn' in request.POST:
            condition = request.POST['sp_name']
            if Spell.objects.filter(sp_name = condition).exists():
                entry = Spell.objects.get(sp_name = condition)
                entry.delete()
                Classspell.objects.filter(clsp_name = condition).delete()
    all_spells = Spell.objects.raw('''
        SELECT *
        FROM spell
        GROUP BY sp_name
    ''')
    print("BEFORE RNDER")
    return render(request, "DDChar/spells.html", {'allSpell':all_spells})

def createSpell(request):
    if request.method == "POST":
        print("POST success")
        form = spellForm(request.POST or None)
        if form.is_valid():
            form.save()
        return render(request, "DDChar/spells.html", {})
    else:
        return render(request, "DDChar/spells.html")

