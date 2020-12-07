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
        print("POST Success")
        form = spellForm(request.POST or None)
        if form.is_valid():
            print("SAVE")
            form.save()
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

