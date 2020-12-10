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

    all_characters = Playercharacter.objects.raw('''
        SELECT pc_name FROM playerCharacter
    ''')

    if request.method == "POST":
        character = request.POST["character"]
        attribute = request.POST["attribute"]
        character_info = User.objects.raw('''
        SELECT u_key, u_name, pc_name, pc_key, pc_class, pc_level, bg_race, bg_age, bg_alignment, cl_name
        FROM user, playerCharacter, background, Class
        WHERE u_key = pc_key AND cl_id = pc_class AND pc_name = bg_name AND pc_name = %s
        GROUP BY u_name;
        ''', [character])
        if attribute == 'weapons':
            wpn_attribute_info = Weapon.objects.raw('''
            SELECT wpn_name, wpn_range, wpn_damage, clwpn_prof FROM Weapon, classWeapon
            INNER JOIN playerCharacter ON pc_class = clwpn_id
            WHERE wpn_name = clwpn_name AND pc_name = %s
            ''', [character])
            return render(request, "DDChar/index.html", {'character_info':character_info,'wpn_attribute_info':wpn_attribute_info, 'all_char':all_characters})
        elif attribute == 'spells':
            sp_attribute_info = Spell.objects.raw('''
            SELECT sp_name, sp_slotlevel, sp_range, sp_castingtype, sp_effect, sp_die FROM Spell
            INNER JOIN ClassSpell ON ClassSpell.clsp_name = Spell.sp_name
            INNER JOIN Class ON Class.cl_id = ClassSpell.clsp_id
            INNER JOIN playerCharacter ON playerCharacter.pc_class = Class.cl_id
            WHERE pc_name = %s AND sp_slotLevel <= pc_level
            GROUP BY sp_name;
            ''', [character])
            return render(request, "DDChar/index.html", {'character_info':character_info, 'sp_attribute_info':sp_attribute_info, 'all_char':all_characters})

    return render(request, "DDChar/index.html", {'all_char':all_characters}) #Pass all to html via dictionary

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
        if form.is_valid():
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

def edit(request):
    if request.method == "POST":
        if 'editbtn' in request.POST:
            sp_name = request.POST['sp_name']
            spellEdit = Spell.objects.filter(sp_name=sp_name)
            sp_slotlevel = spellEdit.values('sp_slotlevel')
            sp_range = spellEdit.values('sp_range')
            sp_castingtype = spellEdit.values('sp_castingtype')
            sp_effect = Spell.objects.filter(sp_name=sp_name).values('sp_effect')
            sp_die = spellEdit.values('sp_die')
            return render(request, "DDChar/edit.html", {
                'sp_name':sp_name,
                'sp_slotlevel':sp_slotlevel,
                'sp_range':sp_range,
                'sp_castingtype':sp_castingtype,
                'sp_effect':sp_effect,
                'sp_die':sp_die,
            })
        if 'editsubbtn' in request.POST:
            print("EDIT BUTTON")
            form = spellForm(request.POST or None)
            sp_name = request.POST['sp_name']
            sp_slotlevel = request.POST.get('sp_slotlevel', False)
            sp_range = request.POST['sp_range']
            sp_castingtype = request.POST['sp_castingtype']
            sp_effect = request.POST['sp_effect']
            sp_die = request.POST['sp_die']
            spell_object = Spell(sp_name=sp_name, sp_slotlevel=sp_slotlevel, sp_range=sp_range, sp_castingtype=sp_castingtype, sp_effect=sp_effect, sp_die=sp_die)
            spell_object.save()
    return render(request, "DDChar/spells.html", {})

