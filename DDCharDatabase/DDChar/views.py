from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from .models import *
from django.db import connection

# Create your views here.
def index(request):
    print("Rendered index")
    all_members = User.objects.all
    return render(request, "DDChar/index.html", {'all':all_members}) #Pass all to html via dictionary

def spells(request):
    print("Rendered spells")
    return render(request, "DDChar/spells.html")

