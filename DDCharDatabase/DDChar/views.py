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
    all_spells = Spell.objects.raw('''
        SELECT *
        FROM spell
        GROUP BY sp_name
    ''')
    print("HERE")
    return render(request, "DDChar/spells.html", {'allSpell':all_spells})

def createSpell(request):
    if request.method == "POST":
        form = spellForm(request.post or None)
        if form.is_valid():
            form.save()
            print("SAVED!")
            return spells(request)
    else:
        return render(request, "DDChar/spells.html")

