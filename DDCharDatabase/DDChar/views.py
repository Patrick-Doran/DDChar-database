from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from .models import * #VSCode hates this, I don't know why, it just does
from django.db import connection
from django.db.models import Q
from .forms import *

# Create your views here.
def index(request):
    print("Rendered index")
    all_members = User.objects.raw('''
        SELECT u_key, u_name, pc_name, pc_key, pc_class, pc_level, bg_name, bg_race, bg_age, bg_alignment
        FROM user, playerCharacter, background
        WHERE u_key = pc_key AND pc_name = bg_name
        GROUP BY u_name
    ''')
    return render(request, "DDChar/index.html", {'all':all_members}) #Pass all to html via dictionary

def spells(request):
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
        if 'searchbtn' in request.POST:
            searchRes = request.POST['search']
            print(searchRes)
            if Spell.objects.filter(Q(sp_name__startswith=searchRes) | Q(sp_range__startswith=searchRes) | Q(sp_castingtype__startswith=searchRes) | Q(sp_effect__startswith=searchRes) | Q(sp_die__startswith=searchRes)).exists():
                searchQuery = Spell.objects.filter(Q(sp_name__startswith=searchRes) | Q(sp_range__startswith=searchRes) | Q(sp_castingtype__startswith=searchRes) | Q(sp_effect__startswith=searchRes) | Q(sp_die__startswith=searchRes))
                print(searchQuery)
                return render(request, "DDChar/spells.html", {'singleSpell':searchQuery})
    all_spells = Spell.objects.raw('''
        SELECT *
        FROM spell
        GROUP BY sp_name
    ''')
    print(all_spells)
    return render(request, "DDChar/spells.html", {'allSpell':all_spells})

def createChar(request):
    if request.method == "POST":
        form = charForm(request.POST)
        if form.is_valid:
            u_name = request.POST['u_name']
            u_key = User.objects.filter(u_name=u_name).values('u_key')
            pc_name = request.POST['pc_name']
            pc_class = request.POST['pc_class']
            cl_id = Class.objects.filter(cl_name=pc_class).values('cl_id')
            pc_level = request.POST['pc_level']
            bg_race = request.POST['bg_race']
            bg_age = request.POST['bg_age']
            bg_alignment = request.POST['bg_alignment']
            
            pc_object = Playercharacter(pc_name=pc_name, pc_key=u_key, pc_class=cl_id, pc_level=pc_level)
            bg_object = Background(bg_name=pc_name, bg_race=bg_race, bg_age=bg_age, bg_alignment=bg_alignment)

            pc_object.save()
            bg_object.save()

            
    return render(request, "DDChar/createChar.html", {})

